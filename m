Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55923C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C4B222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DJTlEIGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C4B222B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UPgTwplK7Wc8Jqat8X3nJe+qZnOcc88BRw4SI16nQOk=; b=DJTlEIGjPED2hN
	ardG4XUz8544i+Ohsf6FmXnGPyR5YmeNgSU4avW2tDxpzUyn8QQIcLRW61FRJOLNG6K9QJLov9X4e
	ZvTjLcMh8VlS+2wWS24yBrUXMj+ohCHISZ75ulCRM3dMEiwU7uvwJa+76ji+30mUGVIExXDKG43Dj
	7DQXcQQgXsTJ5cdgR+9LtGwtzBveRFAe8fArNL672LZzSkBZlumXcL8J0PV8a9s4R+ZWIcsB4eGXG
	l4MjVf3wSlzYdS6dKof9dgHl1bKZa2Pry6N79toVZaaPwCJ0puzWtPsi3xaCeIUvoaDIxxr561qTA
	ZgtVZnMVK+3QYQ9bxJgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtvaA-0005vt-Pt; Wed, 13 Feb 2019 14:32:14 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtva2-0005jg-5f
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 14:32:08 +0000
Received: by mail-qt1-f195.google.com with SMTP id 2so2751458qtb.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 06:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yQjmZowm/ZKBxge9W+Z0hhgJKB8GgrmSu4tCCYAjf2o=;
 b=mgOqGDaHxbYFioqhF7czTbqq8999rNbem+nBZcCUmgKkORyhxzgjrt1GEwKe9l5VF0
 dNwP7nIxhGdETzDhhQ3LpwrGGW3T4ltOFFgNZ3HwTN9+k6c8wvCGalU8n7po37PFWRMY
 U2awUYUinAkvfXOIApIVY7jni7qpqMhus4F6FWJka/9KxPwjTvpGIQ1lCLLjNxah8UOl
 wwQvqHZ1KaIMTaEusb4Ox/cw/JzqsFPOY1h0sCTqhKwtQqWIpWx6xi3ucTYi1eKYFf1/
 4ecHFU3bJDbz61NliUNhN0+YykQQg9ChT4vhXC2uNuPTZLjadbKbawgJnk2hLs77xsCZ
 kdLw==
X-Gm-Message-State: AHQUAuZWCMY+Drg01AOeXXIT2tXuduhpEerBC18JXx1RcYHi19vXxvBA
 F6HaoSBiyVSKP8fXajC42sylAgIDk77vNzKUvB4=
X-Google-Smtp-Source: AHgI3IbBDEPON02dOFX651H6FLMPKtV3GSRs3pPWsKyjo0nsyKsTGsVP1M9c7PuPbLx6Ic4qJnXnSiMwE1XB+F7pj2w=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr594004qve.180.1550068324570;
 Wed, 13 Feb 2019 06:32:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550060543.git.baolin.wang@linaro.org>
 <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
In-Reply-To: <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Feb 2019 15:31:47 +0100
Message-ID: <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
To: Baolin Wang <baolin.wang@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_063206_360924_BE90B7B2 
X-CRM114-Status: GOOD (  10.51  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Lyra Zhang <zhang.lyra@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 1:34 PM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Remove wildcard compatible string.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>


Looks good to me. It does break using the new dtb file on older kernels,
but I suppose this is not a case we care much about yet on your
platform, given that both the dts file sand the drivers in the
kernel are still  work in progress.

I had started the other reply I just sent before I saw this new mail.

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
