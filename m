Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460C9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2072064C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="plm83WMv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="AInBwZDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2072064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xl/q5t4DSnpRbLcbIAir6ft5MJVWUUvF36/XNYpJY+o=; b=plm83WMvVB7rUy
	NeSFa6pZwys6g6ve4X0if3Euiw3d+eqEtwCDDGARK94T9ixHj8c3uHXvvxWMbMsjbfOmR1lsoz8Qm
	ovZ+TxLyoSJ1lRI9gKL2ZexYDQzeHRlGlE4yaaq/FJptrcGz/ieAH4fFzoXDpF7bssQ6d5Lx08p3p
	WiTZIqnxwajlm7yCtSen4+oFh2aLIk30XkkICjbvLfLugSUrXOMGpo54klny3TyBPTVqhV91NmUF8
	gVAsJj+FTuxDJKpcjF8NMNYKkXj8CEPQBTlpdidgVyV+7Bf/+DVHT6MbX/nXA72rdC+waf7lUNglF
	c7Aov/0n9SagYjJJFV0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guYmb-0002U2-Dq; Fri, 15 Feb 2019 08:23:41 +0000
Received: from plaes.org ([188.166.43.21])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guYmX-0002TN-TK
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 08:23:39 +0000
Received: from plaes.org (localhost [127.0.0.1])
 by plaes.org (Postfix) with ESMTPSA id A92744047A;
 Fri, 15 Feb 2019 08:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
 t=1550219012; bh=ckAK7AXQRSsjXHWNEduXvTRaEOebA8RyIaaB9YDmmLo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AInBwZDCAtQcC7OVuEPrlJ85mGxD1OScAfknlfiozrsbxtF8nBcHGnPf9rtXa1FZW
 9jx3RfOwuUecT/iY/AonOWQaiS2N1Y2LfZd2qVVsfplVoIUIsnZLRmkzIc1CfL5bHb
 ZwHohj7ildDqvIliAL2bLZTT1zuREj7MbFxFrrhUlt/FzhaI0fYycXdY5Ncq6WtKaQ
 zvJ4iVK2qZvq9WhXEH07L4bRt9kBBb9YHIvnubsRVdoWeu/YuuUoGJq6vPaChKmEI5
 yVdvUHjYWpHOvVl+w8nZNc4+Mi1gIaUig9axpG9eYzl6rFPx+ZL0/bsGQ0nh6adSZf
 29UPjf1KravXw==
Date: Fri, 15 Feb 2019 08:23:31 +0000
From: Priit Laes <plaes@plaes.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3 05/11] drm/bridge: Add Analogix anx6345
 support
Message-ID: <20190215082331.7wq6arctd4hdjcnh@plaes.org>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-6-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215050957.20755-6-anarsoul@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_002338_089220_E2613060 
X-CRM114-Status: GOOD (  19.05  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
 dri-devel@lists.freedesktop.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 09:09:51PM -0800, Vasily Khoruzhick wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> The ANX6345 is an ultra-low power DisplayPower/eDP transmitter designed
> for portable devices. This driver adds initial support for RGB to eDP
> mode, without HPD and interrupts.
> 
> This is a configuration usually seen in eDP applications.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/bridge/analogix/Kconfig       |  11 +
>  drivers/gpu/drm/bridge/analogix/Makefile      |   1 +
>  .../drm/bridge/analogix/analogix-anx6345.c    | 845 ++++++++++++++++++
>  .../drm/bridge/analogix/analogix-i2c-dptx.c   |   2 +-
>  .../drm/bridge/analogix/analogix-i2c-dptx.h   |   8 +
>  .../bridge/analogix/analogix-i2c-txcommon.h   |   3 +
>  6 files changed, 869 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> 

[ ... ]

> +
> +static int anx6345_start(struct anx6345 *anx6345)
> +{
> +	int err;
> +
> +	if (!anx6345->powered)
> +		anx6345_poweron(anx6345);
> +
> +	/* Power on needed modules */
> +	err = anx6345_clear_bits(anx6345->map[I2C_IDX_TXCOM],
> +				 SP_POWERDOWN_CTRL_REG,
> +				 SP_VIDEO_PD | SP_LINK_PD);
> +
> +	err = anx6345_tx_initialization(anx6345);
> +	if (err) {
> +		DRM_ERROR("Failed transmitter initialization: %d\n", err);
> +		goto err_poweroff;

You can move the whole err_poweroff section from below here and drop the goto.

> +	}
> +
> +	/*
> +	 * This delay seems to help keep the hardware in a good state. Without
> +	 * it, there are times where it fails silently.
> +	 */
> +	usleep_range(10000, 15000);
> +
> +	return 0;
> +
> +err_poweroff:
> +	DRM_ERROR("Failed DisplayPort transmitter initialization: %d\n", err);
> +	anx6345_poweroff(anx6345);
> +
> +	return err;
> +}
> +

[ ... ]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
