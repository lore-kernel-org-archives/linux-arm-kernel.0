Return-Path: <SRS0=kGow=PH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:22:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7D220836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hJL+bgSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7D220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DEDmXrqv65yQX7His9BxQJeK8hpGMc2Vljf8AM0NdQ8=; b=hJL+bgSMB/yXOH
	nKi2pMqgVG1bVsY6XbOUwUmg6AKADmPGV44L5vg2xdg2yYY/+p5YIB9lXqs0xP6e4qrY+9M20jgeP
	BO+9Wz1J+VPZDxbo+9pHDd+7Y5E7IOAJTyo2VhfGVGA4XH/6YUT3xn/eSmjln1SQfxR+xJO2qJYk6
	mehhqeUv5YMIDddY+IfpMZfCMn+R4BKXRe5lXv8h3tCpuUzVUhhbYZkIfRnKjn+iImqk1y/SxaEH6
	ydOwpUn88meUEU//k6VGeicXcuYdERq2tke6GVUZEyTVJ4sLD84iPW0hcETsRgjnEGMPdP3ldrYhm
	XEnySZzNrbIF6/LmwX2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gden8-0005nv-Bg; Sun, 30 Dec 2018 17:22:22 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gden5-0005nD-Gw; Sun, 30 Dec 2018 17:22:20 +0000
Received: from [46.183.103.17] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gdemo-0003gf-4o; Sun, 30 Dec 2018 18:22:02 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 3/7] drm: rockchip: vop: add rk3066 vop definitions
Date: Sun, 30 Dec 2018 18:22:00 +0100
Message-ID: <154632658.xpTMZOjgxT@phil>
In-Reply-To: <20181229133318.18128-4-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20181229133318.18128-4-jbx6244@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181230_092219_765044_838A4030 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Johan,

Am Samstag, 29. Dezember 2018, 14:33:14 CET schrieb Johan Jonker:
> From: Mark Yao <mark.yao@rock-chips.com>
> 
> This patch adds the rk3066 VOP definitions.
> 
> The VOP or LCD Controller serves as interface between
> framebuffer memory and a display device (LCD panel or TV set).
> 
> This SOC has two symmetrical LCDC's for a dual panel application.
> 
> A LCDC has 5 display layers.
> Only 3 are used here.
> 
> - Video layer 0 (Win0)
> - Video layer 1 (Win1)
> - OSD layer     (Win2)

Patch itself looks good, we'll need to wait a bit to give Rob a chance
to look at the (simple) dt-binding change and I'll drop the paragraph
about the display layers when applying.

Looking at the rk3066-manual, the lcdcs really only have 3 fully usable
layers + the special cursor layer which is right now not really usable in
a drm context, so the above paragraph is misleading, so I'll just drop it.

Heiko


> Win0 and Win1 are exchangeable.
> Maximum resolution is 1920x1080.
> 
> The LCDC0 output is connected to:
> - LCDC0 IO (without IOMUX)
> - HDMI TX video input
> 
> The LCDC1 output is connected to:
> - LCDC1 IO (with IOMUX)
> - HDMI TX video input
> 
> The HDMI TX input can switch between LCDC0 and LCDC1.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
