Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:40:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1909A20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ka7kpzWZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e79UzZ4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1909A20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=01WNADcaimF/3K94icmasuqK6cSTXhALx1hWv4edz1Y=; b=Ka7kpzWZH4gZzU
	DR5TYacd52R3EUP/aLuvg1RvFhJzHLGT4iXi6eoEkNCElGzNPZo9QHifMBDO0vtHaN4iV91G+b0Ca
	TgwXB1p8RYJFoOvv491+p5Ldq66aNzq1zjKQ1v66F9Ux04FCrwgLgVIeRwEgUFVoem2xa7meN7gKD
	oUh/TUw2qYr21JTKxeGJVtpjpwBswc+jbrCqdBYKbFTq7g9EJQTmAS240mrh8LJqS53vVyeZqBT1j
	rF/MNNZVWB65EXnAuSUEknwFZqEc9ThHO3j5kqVSbz6f2Y6luDZaBLBpy+CDO5dyjOL/fiTSxo5KS
	rH7IMcjzWraXRvAnjPgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwi1u-0001pn-9w; Thu, 21 Feb 2019 06:40:22 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwi1r-0001pL-7G
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 06:40:20 +0000
Received: by mail-oi1-x242.google.com with SMTP id q81so563463oic.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 20 Feb 2019 22:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DId3EczNJmPuSYVXChV6P1cuILrHJcLT/vynhKnZcqg=;
 b=e79UzZ4tF3mCmhUE3wc0HUMo1MEBfzeKnnX84wsYAwfFiinQxxDMAoK7aulNUPti6T
 D8Tmz043MiTv/2YqsF27Oogt+dNCjP5AgFHcov4NCpgB9dilKWWuqptSZre6KocL6sa6
 lJH4GY8jYw8/EusMzYSvuPk/b/HushGP/c2jMWmaNrKKASrNh+HmHIcLWpI5U6yXWfb8
 c3rFyRgSNkYAkHUA29RZdI/Q3/apfQcImymoshtvxS8aD5AXE3zwtfy3JCEgyyJq/Fq7
 +7sM3ZRhygQ6b1ayuHFhbMvJKPeoFiQE0OK8bHSsrY5JPlpDtO78j9JNAze+HvPlHzqE
 PL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DId3EczNJmPuSYVXChV6P1cuILrHJcLT/vynhKnZcqg=;
 b=PReFRVbeA4Av0lLJ6xfJkBGlVZSWDwUnLTddRxOy0IDcq2Es+MrebPCIEzuYp4tJO8
 /C4tz0tvDd+M2oJ8EH2ZAnwePdmSBtddxfTD+Dh4bpp55x/FAHq1RsRNyjKj8i4MpOWd
 yHlTBgPfIbRkPzmK0rJ0KiLI6zlu9QVgdBm0vJ/UQZCWdgmd5Ha8oddiKWpd3Ba/Yj7v
 +dUUnmyaQ/rGyr54zjeWU+7uD5Bts3TEcJcFl7BWglLWoMr25XWPn006YpMcNBgRuBDE
 mrf6F4s44bTmo32nwxHkFJV2SxLrix7toUlMg27icF4Sex/txDBgbLAznFejSMmZ5tPC
 3Xvw==
X-Gm-Message-State: AHQUAuacmi6rSguhDA4a6os2+l37PTAMtFEb8tVX3RRNGeGVoiwjPQS/
 zgDm1MvwnK2IbPoMabPfagXzINakjippe6+iXys=
X-Google-Smtp-Source: AHgI3IahjipocvG92w+SIbwbz8+8Pbq0YwiEXQTIp75iklfZwdpj7GP4mkciGJMabQbHUYNg8UrcuIgRoh/kseO9jqA=
X-Received: by 2002:aca:c142:: with SMTP id r63mr8680208oif.98.1550731217599; 
 Wed, 20 Feb 2019 22:40:17 -0800 (PST)
MIME-Version: 1.0
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-7-anarsoul@gmail.com>
 <20190218182629.GA14714@bogus>
 <CA+E=qVfDfDvVmKQDeh2e0SA=tm6VpBMpu9MPKUqxFPObxYFXDg@mail.gmail.com>
 <20190219085626.7poutwvm3lrilnon@flea>
 <CA+E=qVfV8ds-zb0oG1-g8c-ReCSnZjfUjvAHbZf1zBf8H-xUcw@mail.gmail.com>
 <20190220103347.74wqu2btdti2myi7@flea>
In-Reply-To: <20190220103347.74wqu2btdti2myi7@flea>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 20 Feb 2019 22:39:51 -0800
Message-ID: <CA+E=qVdP8Ocds2Ojv5PzvwowGKb-od21bRgAtC==Z8CNfYszQw@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] drm/sun4i: rgb: Add DT property to disable
 strict clock rate check
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_224019_285228_406A504D 
X-CRM114-Status: GOOD (  17.46  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Archit Taneja <architt@codeaurora.org>,
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 arm-linux <linux-arm-kernel@lists.infradead.org>,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 20, 2019 at 2:33 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Feb 19, 2019 at 07:44:56AM -0800, Vasily Khoruzhick wrote:
> > On Tue, Feb 19, 2019 at 12:56 AM Maxime Ripard

> > Maxime, thanks for your patch but  it doesn't work for me. Pinebook
> > needs 1% tolerance. Having it as a module parameter means that no
> > distro will be able to boot on Pinebook out of the box.
>
> I don't really know what to tell you, the VESA spec defines everywhere
> that tolerance, and if we're not able to provide that, then we're not
> compliant and I don't want us to not be compliant just because one
> panel needed to be a bit more flexible, and especially since what
> could work on one panel might fail on another one.
>
> If you want alternate solutions, then please answer to:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/630441.html
>
> or provide the EDID blob.

Uh, I spoke to early, my bad. I made a mistake when I calculated rate
deviation for 768p last time - I took 73MHz as dotclock, but actual
requested rate 72.3 MHz and it gets 72.296296 MHz, so it's within 0.5%
tolerance. 1080p pinebook needs 138.5 MHz and gets 138.461538 MHz -
also within 0.5%.

However your patch has an issue, I'll respond to your previous email.

> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
