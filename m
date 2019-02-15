Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:28:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C5D2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQhUyUYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C5D2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QGjHjLZIQTAUwRx2Zo8Qd25imWIEqcTHWzH5987DkLE=; b=fQhUyUYL8YpzNf
	SOq+YWAXutE5r+ueEWY39s/fVPSos+0LU/kv9yADuAvok7624W3jy2TT03dOmmt2AHlmO5KRT7coK
	fqgAEMxUcH52RvGJvPmGM8qQq2gVp1Xy4z73agkUlZrQ5ZhJNM6FCGnv4tRFQPGQpWamlszuUI/6Q
	yZNn1R+X7m1F07ywjAyn/SFEDojxGwcQBYpylBTZSqs5BhO83oQc741GyAVfOwY3ulodbjle/IimO
	W1/7asO3/wUDpMxjvrN44jEYpBLhuqYsyUDEx1WzIJ64+vkYSAKMlaLiCLzKLbnFhHE757HZD/1dY
	j9A4oqNFP/Tuh5S131zQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueTp-0004Xy-7c; Fri, 15 Feb 2019 14:28:41 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueTm-0004Xg-7g
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 14:28:39 +0000
Received: by mail-qt1-f196.google.com with SMTP id j36so11009452qta.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 06:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AjU1B+hB3cJRwHDnLuRx/W/9MxrDmMayDmoYArfmCV4=;
 b=FHAU+NN+gcFOc1X+rop0T37pn2SAkNzFPOI/F/VTscbP7GU/4DNbiDieji9lHTZUUS
 hJ8ZtQutn8dzqHK3P5IarJtR7324XfAaziw72AWrC9mvMnudSAYBNY2sRr7o3MSe9IFU
 m6h9LRph/drg/uo5YqqjV2OhYieFvMuo7w5hcHPJhmPeGKk/6bm3MbhhTnSN0oChX/6K
 H2MDGWG1AM3gwqGcFyYLa4Hx4heV/jl6NShT1D8Db+WeyScgRLK22AwFNFCiOGVzRmo7
 e+fzxxD+7lcsDgQ5+BdiTBrI+fVFUChXfzyf5g3xQaE/U/J4kq6vTHlUbHVAgMIKpTAf
 vI4g==
X-Gm-Message-State: AHQUAuaqUM/M73JethCiEjIUNs8ZF0ZtE2IsagfD5ICL+qMC0AiUXqcR
 Np3k3vrccL66NIvQ9iML/QDOTuA1WGnYfhmvGT8=
X-Google-Smtp-Source: AHgI3IZuvNfzxKU+5o7RBCY6cRmSiXBvs/4x4U8k3PQFK7+UXNYfQ6/t1Y7ypSu0O+pMBPWriYNgTC6P88HltdepHDQ=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr7683012qtn.212.1550240916906; 
 Fri, 15 Feb 2019 06:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20190202172237.11147-1-f.fainelli@gmail.com>
 <20190202172237.11147-3-f.fainelli@gmail.com>
In-Reply-To: <20190202172237.11147-3-f.fainelli@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 15:28:20 +0100
Message-ID: <CAK8P3a2LMNBsTZioSAnCAEacF3hbxR_WXciDs-3nCtuj654jAw@mail.gmail.com>
Subject: Re: [GIT PULL 3/4] Broadcom devicetree-arm64 changes for 5.1
To: Florian Fainelli <f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_062838_278140_A90C2C11 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Kevin Hilman <khilman@kernel.org>,
 Eric Anholt <eric@anholt.net>, arm-soc <arm@kernel.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 2, 2019 at 6:22 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> This pull request contains Broadcom ARM64-based SoCs Device Tree updates
> for 5.1, please pull the following:
>
> - Stefan adds support for the Raspberry Pi 3 A+ by using the same
>   mechanism of creating a symbolic reference to the ARM 32-bit DTS file
>

Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
