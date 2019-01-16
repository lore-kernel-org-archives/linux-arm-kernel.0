Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2377C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:35:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DC320868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tYrsrLbR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="Hgdp3Uqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DC320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YB8GQZxMoZj6H4IasJd7y+FgrMsQlJz96JcoME4UYbU=; b=tYrsrLbRXpl+/2
	2gLUmBbTZHgYKAxE5xSIWNnJ2rwGftT4kIqYf/s2E77hZHH9jKjAvKh5aggvba3ilr5Zg2HEeIxxy
	ZD42Pf0jD7G7pScvRIuxExQ4d5C5VMr5ofDoelmoHeP6IFcXi1E4Rc32bC4z0QOyrWQw9il4Q26UI
	OoC9XO/QGyGAU42FlfKqePR9O4lKrX3h9Kkv56GXpiF/W/Fd5+5CEBM0A4Ezee47dBs4E9GvByrJF
	4NP7AlViT5bPbaUc8wmGm9af4DZRZHYnHEZgWxF7PXuFrdm6qotRamJAbcMQM3Dqm4BjSu3ilbANn
	lOCrGhYoFh7V0g0vOLRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjruk-0004KA-CJ; Wed, 16 Jan 2019 20:35:54 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjruf-0004Jj-Tw
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 20:35:52 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id 9BE4440AA6;
 Wed, 16 Jan 2019 20:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1547670917; bh=bn215B21gRihGf3bMn6PuAByBgT6+Vbj1t3TWWXNTg8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hgdp3UqxfSKzt4QFKa1sNLc/sAkkPA9JMBe8eoSV2eJIsFLixSCT+KzxV+YJkt1Cn
 bFblgnHcfM7DBfsmO791rc8rJ63N8Ff5At4n6/cjtwyxC5khjKkI7PNuThMK2ZknZf
 y76PTSDDXrSdrMTvygkk/sPH8LOfAnGpeQCIyGH0T9EuWWKU7d5b5l5mm5da4jwwIX
 qCUKCWxd+akn5XNURTf4zvz7oEOqB+3hw7CBA5x6pB6EKx3x1RQVaX9qotq0Y8xPTJ
 olMrhNCy9KimJDT3suE/Q0SOchd23/7qZLx/zGROJj8//NNC4kk7yFY6hA9DL6JK1B
 UAZZZNy0xdRGQ==
Date: Wed, 16 Jan 2019 20:35:16 +0000
From: Priit Laes <plaes@plaes.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [linux-sunxi] Re: HDMI/DVI spurious failure
Message-ID: <20190116203516.s7pisy4miaclo63u@plaes.org>
References: <20190114132934.rywqqtjarbf6fgcr@plaes.org>
 <20190115094951.e7jnjpibj5tcp5pz@flea>
 <20190116075854.o2kme5nxq5kckwem@plaes.org>
 <20190116192442.qz4xi2ky6axgiyvg@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190116192442.qz4xi2ky6axgiyvg@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_123550_335235_132903A4 
X-CRM114-Status: GOOD (  23.25  )
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
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
 Chen-Yu Tsai <wens@csie.org>, Jonathan Liu <net147@gmail.com>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 16, 2019 at 08:24:42PM +0100, Maxime Ripard wrote:
> Hi Priit,
> 
> On Wed, Jan 16, 2019 at 07:58:54AM +0000, Priit Laes wrote:
> > > On Mon, Jan 14, 2019 at 01:29:34PM +0000, Priit Laes wrote:
> > > > I have a somewhat curious case with one HDMI/DVI screen that fails
> > > > to initialize properly every 6-7 boots. The display itself is also
> > > > somewhat flawed (missing HPD pin and the VSYNC/HSYNC pulse width
> > > > is set to 0 in EDID), but I suspect there could be some issues
> > > > regarding timing in A20 HDMI driver in Linux.
> > > > 
> > ...
> > 
> > > It doesn't look related to the clock rate itself, since it doesn't
> > > change between the two cases. However, in one case the DDC clock is
> > > enabled and in the other it's disabled.
> > > 
> > > Was it taken at the same time? Maybe you can try with that patch?
> > > http://code.bulix.org/z7jmkm-555344?raw
> > 
> > Thanks, after doing ~50+ boots I haven't seen a single failure.
> > 
> > Previously I had following failure cases which are now both fixed:
> > 
> > a) Linux without u-boot HDMI, where one in every 6-7 boots failed.
> > b) u--boot with hdmi enabled switching to simplefb and then switching
> > to kms, where previously all boots ended up with garbled screen.
> 
> So it's not really a fix, but it really looks like the clock is not
> enabled when it should.
> 
> Can you describe your test scenario a bit more? What are you doing
> exactly, just booting? When do you start using the display? When did
> you capture the debugfs output that you pasted?

Display is already connected via HDMI to the board. I don't really
remove it, I just boot the device and let it start Xorg.
Meanwhile I just ssh into the device and capture debugfs output.
See my 3 testing scenarios below.

Kernel also includes one extra patch to fall back to DDC, in case HPD
fails. Mostly the same I already submitted last November [1].

For u-boot I have also some extra patches, to detect HPD-less HDMI
displays [2] + relax some EDID timing checks [3] so u-boot can actually
initialize my screen.

So first configuration with 100% failures:
1) u-boot initializes HDMI ( A20-OLinuXino-Lime2-eMMC_defconfig )
2) Linux switches to simplefb
... somewhere around here blinking cursor is replaced with garbage
on screen 
3) Linux switches to kms
4) Xorg starts

Second scenario with failure every 6-7 boots:
1) Disabled HDMI in u-boot for my board
2) Linux sets up kms (sometimes fails here)
3) Xorg starts
4) ssh to machine and take the clock dump

Third scenario with no failures (but not suitable in long term..)
1) Disabled sun4i HDMI driver (CONFIG_DRM_SUN4I_HDMI=n) in Linux
2) u-boot sets up HDMI
3) Linux continues with simplefb
4) Xorg (with fbdev) starts


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/613168.html
[2] https://lists.denx.de/pipermail/u-boot/2018-December/352541.html
[3] https://lists.denx.de/pipermail/u-boot/2018-December/352540.html
> 
> Thanks!
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
