Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E58C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA1A520855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rqtux69H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1A520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BNYjLCznqzt4fZLpyHooHtPZaIMtvW3f/xwBipCSar4=; b=Rqtux69H4JdqCH
	vuTBvzJuIkCLUSQJ1jScPT8otuhoO6znCp4jgTDj30Fboip6BjE8HC1OFbtoKsIFqHdwSLIBt7/R9
	OnEQN7Co2fb1DRWM1zm5NaMXyXXmPv/dLSVOC9EDV/c6uJDKrTJy5NnM8u/6SAZ522WKPDLoFjTck
	kB7bBcVj2BocBa4aBFhOGuTXCNxtL9XTJdrzY+Cc+IdYRsEUp8bmPmEH0f46Gg2RxM14a2v4ASjFN
	ELfOQLR1pI0ys3kFMb3fAJvCrQSWAdL0SmAy6bRs4bBDAfjojgrnhAGbeaiI9+fCC6lP80uRpBX7M
	+Ql6t44I7U4Iq8tiOWzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsBsN-0006uL-I5; Fri, 08 Feb 2019 19:31:51 +0000
Received: from asavdk4.altibox.net ([109.247.116.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsBsJ-0006tl-Ph
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 19:31:49 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk4.altibox.net (Postfix) with ESMTPS id 89F8C80452;
 Fri,  8 Feb 2019 20:31:41 +0100 (CET)
Date: Fri, 8 Feb 2019 20:31:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] drm/mcde: Add new driver for ST-Ericsson MCDE
Message-ID: <20190208193140.GA30889@ravnborg.org>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
 <20190207083647.20615-4-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207083647.20615-4-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8 a=PkizCq1AaccZmVURKX8A:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_113148_186090_7F2D580B 
X-CRM114-Status: GOOD (  26.55  )
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus.

Good looking driver. A few nits in the following.
I did not try to follow the code, so no proper review done, sorry.

	Sam

> +++ b/drivers/gpu/drm/mcde/mcde_display.c
> @@ -0,0 +1,1284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Linus Walleij <linus.walleij@linaro.org>
> + * Parts of this file were based on the MCDE driver by Marcus Lorentzon
> + * (C) ST-Ericsson SA 2013
> + */
> +#include <linux/clk.h>
> +#include <linux/version.h>
> +#include <linux/dma-buf.h>
> +#include <linux/of_graph.h>
> +
> +#include <drm/drmP.h>

Please do not use drmP.h in new drivers.
drmP.h is deprecated and we are working on gettting rid of it.

> +
> +static void mcde_display_enable(struct drm_simple_display_pipe *pipe,
> +				struct drm_crtc_state *cstate,
> +				struct drm_plane_state *plane_state)
> +{
> +	struct drm_crtc *crtc = &pipe->crtc;
> +	struct drm_plane *plane = &pipe->plane;
> +	struct drm_device *drm = crtc->dev;
> +	struct mcde *mcde = drm->dev_private;
> +	const struct drm_display_mode *mode = &cstate->mode;
> +	struct drm_framebuffer *fb = plane->state->fb;
> +	u32 format = fb->format->format;
> +	u32 formatter_ppl = mode->hdisplay; /* pixels per line */
> +	u32 formatter_lpf = mode->vdisplay; /* lines per frame */
> +	int pkt_size, fifo_wtrmrk;
> +	int cpp = drm_format_plane_cpp(format, 0);
> +	int formatter_cpp;
> +	struct drm_format_name_buf tmp;
> +	u32 formatter_frame;
> +	u32 pkt_div;
> +	u32 val;

...
This is a very long function. Please consider splitting it up in a
a smaller more readable set of functions.


> +	default:
> +		dev_err(drm->dev, "Unknown pixel format 0x%08x\n",
> +			fb->format->format);
> +		break;
> +	}
Despite and unknow pixel format the following code is executed.
Looks wrong, if it is OK then maybe add a comment in the default: case
to say so.

> diff --git a/drivers/gpu/drm/mcde/mcde_drm.h b/drivers/gpu/drm/mcde/mcde_drm.h
> new file mode 100644
> index 000000000000..eea6dc23436a
> --- /dev/null
> +++ b/drivers/gpu/drm/mcde/mcde_drm.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2018 Linus Walleij <linus.walleij@linaro.org>
> + * Parts of this file were based on the MCDE driver by Marcus Lorentzon
> + * (C) ST-Ericsson SA 2013
> + */
> +#include <drm/drm_simple_kms_helper.h>
> +
> +#ifndef _MCDE_DRM_H_
> +#define _MCDE_DRM_H_
> +
It is considered good practice (at least by me) that a header
file includes all necessary files, so users do not need to care.
It looks like a few is missing here.

Also expand the include guards to cover the incldue files
so they are not included twice.
This file is likely only included once, so this is only to make it look
like any other heder file.


> diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
> new file mode 100644
> index 000000000000..cb65609ac812
> --- /dev/null
> +++ b/drivers/gpu/drm/mcde/mcde_drv.c
> @@ -0,0 +1,540 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 Linus Walleij <linus.walleij@linaro.org>
> + * Parts of this file were based on the MCDE driver by Marcus Lorentzon
> + * (C) ST-Ericsson SA 2013
> + */
> +
> +/**
> + * DOC: ST-Ericsson MCDE Driver
> + *
> + * The MCDE (short for Multi-channel display engine) is a graphics
> + * controller found in the Ux500 chipsets, such as NovaThor U8500.
> + * It was initially conceptualized by ST Microelectronics for the
> + * successor of the Nomadik line, STn8500 but productified in the
> + * ST-Ericsson U8500 where is was used for mass-market deployments
> + * in Android phones from Samsung and Sony Ericsson.
> + *
> + * It can do 1080p30 on SDTV CCIR656, DPI-2, DBI-2 or DSI for
> + * panels with or without frame buffering and can convert most
> + * input formats including most variants of RGB and YUV.
> + *
> + * The hardware has four display pipes, and the layout is a little
> + * bit like this:
> + *
> + * Memory     -> 6 channels -> 5 formatters -> DSI/DPI -> LCD/HDMI
> + * 10 sources    (overlays)                    3 x DSI
> + *
> + * The memory has 5 input channels (memory ports):
> + * 2 channel A (LCD/TV)
> + * 2 channel B (LCD/TV)
> + * 1 channel CO/C1 (Panel with embedded buffer)
> + *
> + * 3 of the formatters are for DSI
> + * 2 of the formatters are for DPI
> + *
> + * Behind the formatters are the DSI or DPI ports, that route to
> + * the external pins of the chip. As there are 3 DSI ports and one
> + * DPI port, it is possible to configure up to 4 display pipelines.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/dma-buf.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/component.h>

Please sort include files alphabatically.

> +
> +#include <drm/drmP.h>

And like before, get rid of drmP.h

> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_gem.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_bridge.h>
Also alphabetically sort needed again.

> +
> +#define MCDE_CR 0x00000000
> +#define MCDE_CR_IFIFOEMPTYLINECOUNT_V422_SHIFT 0
> +#define MCDE_CR_IFIFOEMPTYLINECOUNT_V422_MASK 0x0000003F
> +#define MCDE_CR_IFIFOCTRLEN BIT(15)
> +#define MCDE_CR_UFRECOVERY_MODE_V422 BIT(16)
> +#define MCDE_CR_WRAP_MODE_V422_SHIFT BIT(17)
> +#define MCDE_CR_AUTOCLKG_EN BIT(30)
> +#define MCDE_CR_MCDEEN BIT(31)

The register definitions are spread over several .c files.
And that is also nice so it is easy to navigate to the register
definitions in the same file.
But if refactoring then this can be annoying as you may end up with two
files that require the same register definitions.
Consider an own heder file.

> +	if (ret) {
> +		dev_err(dev, "faule to add component master\n");
Spelling error. faule => failed?

> +++ b/drivers/gpu/drm/mcde/mcde_dsi.c
> @@ -0,0 +1,1374 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/component.h>
> +#include <linux/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +#include <video/mipi_display.h>
Alphabetic order.

> +
> +#include <drm/drm_device.h>
> +#include <drm/drm_encoder.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_print.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_of.h>
Alphabetic order.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
