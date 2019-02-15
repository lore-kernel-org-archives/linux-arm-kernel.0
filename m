Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F085C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377052192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8rpB4VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377052192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iPtiVpB2lof8N9lHcaBoWHogy6h7ya7nvjzu1q284rc=; b=W8rpB4VFJg4dff
	vAyDigfjxPxNXFcDliuqf5vLIvzSz65r1KbtF+Hy3uV/WcLfyL2F7DBZ/3QHk6phjVITifZcfadA5
	tUi1fAYExc5xjFdJHV5G1B6CrHQW9l4bVR1qXl4rWr3D/OED6xiGhVd4YcZNX4U2NGcSzlRp5BDzs
	jFdYjKHndOiX2hR8Wgj9Nc5RSoK9mUm96IXDjuR6FQgkcO9JS2A2fpjZk6JnEDAY15UcgFw13vuAy
	Ak7pQdeHr5sdQgpQ+ih80iMBgUo9FmgoBSsZtPS97rhI9NCZ0E+6khvxQ8kiRHqMaRkX0IQ7rGSQR
	edTzFgWSZtWw72uJMt5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufky-0004rq-CN; Fri, 15 Feb 2019 15:50:28 +0000
Received: from mail-qt1-f174.google.com ([209.85.160.174])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufkv-0004rW-OT
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:50:27 +0000
Received: by mail-qt1-f174.google.com with SMTP id b8so11305334qtr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3jjcovRATW7oFSOOb7YSAwHoKQTBOoYX2rkYv5yEL6k=;
 b=KSuJaJh1R4NkDReqg3Ixi/o9QKtrDU1WG8YOthgWF7gsXLdSy0KBWeOLFj5lD1fqQb
 lyydzOIBq/pmaj01tQrr+KXz8KHSXiECdWsDKi1mwlZmwjRgjKHfkVLwpejGWxYsAF8+
 CR86y1SZ4LCd8Rr9H31mz1hMlMPV4gVEYKiFhJ0qqvRkY+Lnh/wfUUIKHhU4oGDUSw3N
 fUdwbdZeTTrD9pFzQIWUbUh8KKrNQcr050OUyWfinUDMqgzu3kb+YmTX2l4K1xdmUCt/
 NrcZzYJNv5IWfrfzM2GxpnoaF/182Wq5xdWSfGJSklwXQDhDK1RW2ximimrkVf60zcIa
 chlw==
X-Gm-Message-State: AHQUAuahMVNL5RSnu3/lgDzdZeD1+r9+L2RTd8tdt5Pm5VjOleXPqHWL
 uQAHFZ2d5jok1uRxw4Z8hw3CSHnJWxKfLTkDZRA=
X-Google-Smtp-Source: AHgI3IagGMt0QlTaqTlzBmXqGF6cVuumFitsSSr96C3639zb8YG6/StMYZWAqb++sOIxSOjJNpDkHBPaJ/i5Ntp4ePU=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7935016qtb.319.1550245824733; 
 Fri, 15 Feb 2019 07:50:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549621233.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1549621233.git.horms+renesas@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:50:08 +0100
Message-ID: <CAK8P3a2+iY5YKO9__-dU+BMbip5nDgA5KEenZSN5LdednhvsDA@mail.gmail.com>
Subject: Re: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v5.1
To: Simon Horman <horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075025_796961_604B9EBD 
X-CRM114-Status: UNSURE (   9.14  )
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
Cc: Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 8, 2019 at 12:13 PM Simon Horman <horms+renesas@verge.net.au> wrote:

> ----------------------------------------------------------------
> Renesas ARM Based SoC Defconfig Updates for v5.1
>
> shmobile and multi_v7 defconfig
> * Enable support for recently upstreamed RZ/A2 (r7s9210) SoC
> * Enable NXP pcf85363 RTC which is used on RZ/G1C (r8a77470) based iWave SBC
>
> shmobile defconfig
> * Refresh for changes present in v5.0-rc1

Pulled into arm/defconfig, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
