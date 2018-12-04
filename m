Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D16C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:09:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCC92082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T/R93vNp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8USsxzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCC92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oGcOEoYiXV5+tJ7QzAjrrwAmXUrkVlE6SSDWkBSKO2Y=; b=T/R93vNpFCYAM/
	Q2ZCFw8hCWOV88t72hvgcmuUwR/v2ploUwVx5oKwAHUD9o1bplORFlBuX4+bDLs1j30aAenIktm2O
	xQQJGWGLxgwwfLHYJJv4Rc2fSbLrH4tQf6y7I/UTvqpkDsfYfEkg7YBVEAw2f0Midpy/LOXhYGC66
	I2LfTZhF+pHmiZU096E2Ip99gc13YeYYRvjuzkeKS1+7uJKEVwT2BRC+NgLVsS918vO9ZTmz2m0AE
	fo2q3pjGzv0CGf9F9deKtuYZogaHMK3gHE319hvqXa0xJTmJxsdFSQ1G0gDpDWKPiftdFg6zavPcq
	q5f6D/uhmkXMk3N3HIOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUG4e-0005LD-Kz; Tue, 04 Dec 2018 19:09:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUG4Z-00057U-1y
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 19:09:34 +0000
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7284B214C1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue,  4 Dec 2018 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543950560;
 bh=+1pw38hDUY4B19iByrUgXT8afzXCScctTML0TwfWjS8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=s8USsxzvlDFDfzrYg1qE/4vpMjtlDh392qdNqTIu+UW7CyhilcEavosUNF8L9qlKV
 3Xyq6gQzQF5N1euf3DnnKphOzs17cBEM5GfxHCmL4L3K+GOq2JDAE+MhFiaFZjnvcx
 ph7U9MDJfx4g/aVooDrmpXVu/DS8pvkdfkTutqMM=
Received: by mail-qt1-f172.google.com with SMTP id v11so19392941qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 11:09:20 -0800 (PST)
X-Gm-Message-State: AA+aEWaTXppQ0VUxTid46YrYVD2HU7qtToabYYIFIYrUr+8qH8f9BwiE
 /6rCq3DsgWrR7tzJAeztK2FL4LYhXIasnzuOnw==
X-Google-Smtp-Source: AFSGD/UEwaDFoE4Mqe0O0pNiLqWe804Ote0QImIGv84HXZ3PoPrQ1zbG8M3c6Pw3jyPYyK7nXFBZimn4R+6lGNK0I0Q=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr19553291qtj.76.1543950559548; 
 Tue, 04 Dec 2018 11:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20181204183649.GA5716@bogus> <20181204184745.GS8952@piout.net>
In-Reply-To: <20181204184745.GS8952@piout.net>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 13:09:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJUt2igJ+42N82J4hh8u=Ai_ez6cyWwNvreU71dTHa4hA@mail.gmail.com>
Message-ID: <CAL_JsqJUt2igJ+42N82J4hh8u=Ai_ez6cyWwNvreU71dTHa4hA@mail.gmail.com>
Subject: Re: Moving ARM dts files
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_110931_521985_C142797D 
X-CRM114-Status: GOOD (  23.05  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andy Gross <andy.gross@linaro.org>, devicetree@vger.kernel.org,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 12:47 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello Rob,
>
> On 04/12/2018 12:36:49-0600, Rob Herring wrote:
> > Olof, Arnd,
> >
> > I've put together a script to move the dts files and update the
> > makefiles. It doesn't handle files not following a common prefix which
> > isn't many and some includes within the dts files will need some fixups
> > by hand.
> >
> > MAINTAINERS will also need updating.
> >
> > A few questions:
> >
> > Do we want to move absolutely everything to subdirs? There's quite a
> > few platforms with only 1-2 platforms. I haven't added these to the
> > list yet, but can.
> >
> > Do any vendors need another level of directories? davinci, omap, nspire,
> > etc. for TI for example.
> >
> > What to do with armv7m.dtsi? I guess it should remain and we just fixup
> > the include. There may be a few other cross vendor things.
> >
> >
> > Sub-arch maintainers,
> > 'vendor_map' below is the mapping of file prefix to new subdirectory
> > (the SoC vendor prefix). Please comment if there are any issues.
> >
> > Rob
> >
> > 8<-----------------------------------------------------------
> > #!/usr/bin/env python3
> >
> > import os
> > import re
> > from git import Git
> > import glob
> >
> > vendor_map = {
> >     'imx': 'fsl',
> >     'ls': 'fsl',
> >     'vf': 'fsl',
> >     'qcom': 'qcom',
> >     'am3' : 'ti',
> >     'am4' : 'ti',
> >     'am5' : 'ti',
> >     'da' : 'ti',
> >     'dm' : 'ti',
> >     'dra' : 'ti',
> >     'keystone' : 'ti',
> >     'omap' : 'ti',
> >     'nspire' : 'ti',
> >     'armada' : 'marvell',
> >     'berlin' : 'marvell',
> >     'dove' : 'marvell',
> >     'kirkwood' : 'marvell',
> >     'orion' : 'marvell',
> >     'pxa' : 'marvell',
> >     'mvebu' : 'marvell',
> >     'mmp2' : 'marvell',
> >     'arm-' : 'arm',
> >     'integ' : 'arm',
> >     've' : 'arm',
> >     'aspeed' : 'aspeed',
> >     'at91' : 'atmel',
> >     'sama' : 'atmel',
>
> Unfortunately, we have many boards without a proper prefix. Wouldn't it
> be better to use arch/arm/boot/dts/Makefile and map dtb-$(CONFIG_*) to a
> vendor directory?

Only 13 boards by my count Atmel. And 2 boards each for omap3 and
Renesas. That's manageable to do by hand or just add to the map.

Though in hindsight I probably would have used the config.

> This way you would be sure to not miss any. This would also ease the
> creation of subdirs if we decide to do that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
