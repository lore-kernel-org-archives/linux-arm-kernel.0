Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496D1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:22:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F4221925
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qr1oHO+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F4221925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=akfkFINRjsQoWDlgBpGwf1Yzk6O3JWBew8BWhC5HmNg=; b=qr1oHO+7Z0DRbE
	rXR6QlnVNEUvUqOtcgp0ilYvyLpEZGRENUOdsZ1+p65wqXk+dQT0A57IcEtOvPuh4JH+K8ynABN5f
	SAY/KGcrOBS/KyQR/jc851vkA3VhFZIfGgG2hBhwze4JTE/fsxtZJGXez9BT2trxVRPa0Oxjmm3sw
	tF4zzA4MwQ3Mx2xSX+0PyJbR15pBC4ZbFouULmcs7pxUJXurM5u/zclVik6l9ZPkXORXpIDutMnVR
	KD8ieAkKDQyBFFAu6ZT6KzrsKWVNCMReggpgb8cSlAqdeAM4pw5Q+WIbR6SSRY3oS49CaMX/wzoC6
	6U6mCe+xglEQtGpYyDOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufJO-0006do-Fm; Fri, 15 Feb 2019 15:21:58 +0000
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufJL-0006dU-Cc
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:21:56 +0000
Received: by mail-qt1-f193.google.com with SMTP id j36so11214326qta.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:21:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uLpIEe7b96kpU8R9OgYMXOprLy2uQxnLOJBKHJCWwO4=;
 b=sXuJ+xHy46aZd3In+9kcpTzlb09jpq7j+7xibUdVs9sbbLqmmys4vUwNUNIDa8/ILw
 ckolPE4BFSOWvqQpDIJV/h5QdRpdZek9MTVHFhAn/Gf7RlRj/7FAxOmGHFoUNG3emR4M
 GsUwsW3IPs/RBB8GSw6CT6i7E6t58XhMK/4VyeF71/FqKhJ7jY2coWpp+rW8J/+UIoO4
 1l1RzgzyUXw54Xz9jWmy/P0AfNP0vrBaWCbItlxDKfIT8LquhZV84E6ZAQVoufXfLDCJ
 H4sHDwp1R/W3Oot1IUUqu/4tp3CnmSo9NabHMwO2MZT1fy0e/R4SSq9b9tUrc24il1OB
 +kow==
X-Gm-Message-State: AHQUAuZuHe/tWnrYK7I2HJKtAO+zjZIECVSzPnG2xD0d/7Dz0lzJHbSZ
 K6ALOoQc4hdOF6vxb6CQimx2bYDNcZlI74xa8pA=
X-Google-Smtp-Source: AHgI3IZ+ol99h5zQTI/7an27yBCrocO4N5fGHpVEy0hhPeH+tC1hN9DeHiXbSLLnnVZ9Z49UTErOgholnZunyBhAGj0=
X-Received: by 2002:ac8:4141:: with SMTP id e1mr7663026qtm.96.1550244114517;
 Fri, 15 Feb 2019 07:21:54 -0800 (PST)
MIME-Version: 1.0
References: <pull-1550167958-188990@atomide.com>
 <pull-1550167958-188990@atomide.com-2>
In-Reply-To: <pull-1550167958-188990@atomide.com-2>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:21:37 +0100
Message-ID: <CAK8P3a0y5FYYOvqPqhDSmR1Jxgx3AJzHtEkuku+_s-1vV_a8Lg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] more dts changes for omaps for v5.1
To: Tony Lindgren <tony@atomide.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_072155_428015_75AE5BFC 
X-CRM114-Status: GOOD (  12.73  )
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 7:13 PM Tony Lindgren <tony@atomide.com> wrote:
>
> From: "Tony Lindgren" <tony@atomide.com>
>
> The following changes since commit b4c30df0eb354d8e081132b7b7449f6d17619614:
>
>   ARM: dts: omap4-sdp: Make ethernet working even if booted with latest u-boot (2019-01-24 08:23:43 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.1/dt-pt2-signed
>
> for you to fetch changes up to 947b7802597106dcbef2ddca23d386f9339ba334:
>
>   ARM: dts: omap3-gta04: declare backlight in lcd node (2019-02-12 10:52:25 -0800)
>
> ----------------------------------------------------------------
> More dts changes for omaps
>
> We add support for Bosch Guardian am335x device, and configure more
> devices like GNSS and LCD backlight for omap3-gta04. And we replace
> the wlcore binding documentation URL with a local file that we have.

Pulled into arm/dt, thanks!

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
