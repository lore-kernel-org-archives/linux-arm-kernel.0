Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9E3C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:56:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A56720838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DrZBX0mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A56720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q2u30C7U3Re1+O9IZtFmDKs/3X2KgeAB6Qkmbk5OUq8=; b=DrZBX0mSM5o2o/
	9Gpd60qVfrinHHq7YM/KLtjg632HkybUzicUgDASOsnMyDG/KXUlm91mI9ZRfM3UwRMjjjw05lieQ
	jTYNL2SGAw4EgwdvHs827NSmXMp5h0iG2id3h+bbASvwBS44/fpDYQQoUnmXqygKTqMkGhTkxsW9w
	47WFdsDQedDPORnAqlR6b/v0LY6gugl3N5hqYHBfsDJqalV3F5UlMtMBhxDCjQNGhXegvibj8Tf2l
	8Kd8xyJ7sw698zUTM8z4MkMgbEpJyM2WO+8acMHZTnQIwPJq3B/7oV981vh91hoZDwzH0iHud/PGO
	pdQx7CjbRbo9fD1F7Fyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt5Vg-0001lQ-S9; Mon, 11 Feb 2019 06:56:08 +0000
Received: from asavdk3.altibox.net ([109.247.116.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt5Vc-0001jN-KE
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 06:56:07 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id 8EC1620030;
 Mon, 11 Feb 2019 07:55:53 +0100 (CET)
Date: Mon, 11 Feb 2019 07:55:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Hean-Loong, Ong" <hean.loong.ong@intel.com>
Subject: Re: [PATCHv12 3/3] ARM:drm ivip Intel FPGA Video and Image
 Processing Suite
Message-ID: <20190211065552.GA7010@ravnborg.org>
References: <20190211060926.3433-1-hean.loong.ong@intel.com>
 <20190211060926.3433-4-hean.loong.ong@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211060926.3433-4-hean.loong.ong@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=yBYpec10AAAA:8 a=fjobobjgAAAA:8 a=QyXUC8HyAAAA:8
 a=jbnKnBcKNtAAbXgpOMQA:9 a=aegFic2g-LuQCSZJ:21 a=er5hxFpQ-oadSlK4:21
 a=CjuIK1q_8ugA:10 a=zbxmTX4fiVD2UiCe4Dha:22 a=PlEKnuvBpV2Z9KzPMKMm:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_225605_025782_664D3B5E 
X-CRM114-Status: GOOD (  21.70  )
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
Cc: devicetree@vger.kernel.org,
 Rienk de Jong <rienk.dejong@quest-innovations.com>,
 yves.vandervennet@intel.com, chin.liang.see@intel.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 linux-arm-kernel@lists.infradead.org, Ong@freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Hean-Loong, Ong

Patch looks good to me, but there is a few trivial
things I spotted while browsing the code.
See below.

	Sam

> +++ b/drivers/gpu/drm/ivip/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the drm device driver.  This driver provides support for the
> +# Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> +
> +obj-$(CONFIG_DRM_IVIP) += ivip.o
> +ivip-objs := intel_vip_of.o intel_vip_core.o \
> +	intel_vip_conn.o

You could use:
ivip-y := intel_vip_of.o intel_vip_core.o
ivip-y += intel_vip_conn.o


Using "ivip-y" is the recommend syntax today.
And using "+=" you get rid of the ugly "\" to continue a line.
(Some people prefer "\" in makefiles, but there are not needed)

> +++ b/drivers/gpu/drm/ivip/intel_vip_core.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * intel_vip_core.c -- Intel Video and Image Processing(VIP)
> + * Frame Buffer II driver
> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Walter Goossens <waltergoossens@home.nl>
> + * Thomas Chou <thomas@wytron.com.tw>
> + * Chris Rauer <crauer@altera.com>
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +
> +#include <drm/drmP.h>
Please do not use drmP.h in new drivers, we try to get rid of this file.

> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_fb_cma_helper.h>
> +#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_plane_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
Sort the list of include files.
(Looks like this was properly done before, and only one file is out of palce)


> +static void intelvipfb_enable(struct drm_simple_display_pipe *pipe,
> +	       struct drm_crtc_state *crtc_state, struct drm_plane_state *
> +	       plane_state)
Fix indent. The parameters on second line and following should be aligned
below the opening paranthesis.
Use tab(s) + spaces to align properly.

> +void intelvipfb_display_pipe_update(struct drm_simple_display_pipe *pipe,
> +				 struct drm_plane_state *old_state)
Align parameter

> +}
> +EXPORT_SYMBOL(intelvipfb_display_pipe_update);
> +
> +static struct drm_simple_display_pipe_funcs fbpriv_funcs = {
> +	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
> +	.update = intelvipfb_display_pipe_update,
> +	.enable = intelvipfb_enable,
> +	.disable = intelvipfb_disable,
> +};
> +
> +
> +int intelvipfb_probe(struct device *dev)
> +{
> +	int retval;
> +	struct drm_device *drm;
> +	struct intelvipfb_priv *fbpriv = dev_get_drvdata(dev);
> +
> +	struct drm_connector *connector;
> +	u32 formats[] = {DRM_FORMAT_XRGB8888};
> +
> +	drm = fbpriv->drm;
> +
> +	drm->dev_private = fbpriv;

It would be simpler to just pass fbpriv as a parameter.
There is only one user of intelvipfb_probe() so no need
to avoid it.

Also it would be more logical to set drm = fbpriv->drm; where memory are allocated.

> +
> +	intelvipfb_setup_mode_config(drm);
> +
> +	connector = intelvipfb_conn_setup(drm);
> +	if (!connector) {
> +		dev_err(drm->dev, "Connector setup failed\n");
> +		goto err_mode_config;
> +	}
> +
> +	retval = drm_simple_display_pipe_init(drm,
> +			&fbpriv->pipe,
> +			&fbpriv_funcs,
> +			formats,
> +			ARRAY_SIZE(formats),
> +			NULL, connector);
Consider indent, where subsequent parameters are aligned right after the
opening '('.

> +
> +	if (retval < 0) {
> +		dev_err(drm->dev, "Cannot setup simple display pipe\n");
> +		goto err_mode_config;
> +	}
> +
> +	drm_mode_config_reset(drm);
> +
> +	drm_dev_register(drm, 0);
> +
> +	drm_fbdev_generic_setup(drm, 32);
> +
> +	dev_info(drm->dev, "ivip: Successfully created fb\n");
> +
> +	return retval;
> +
> +err_mode_config:
> +
> +	drm_mode_config_cleanup(drm);
> +	return -ENODEV;
> +}
> +

> diff --git a/drivers/gpu/drm/ivip/intel_vip_of.c b/drivers/gpu/drm/ivip/intel_vip_of.c
> new file mode 100644
> index 0000000..c899e30
> --- /dev/null
> +++ b/drivers/gpu/drm/ivip/intel_vip_of.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 Intel Corporation.
> + *
> + * intel_vip_of.c -- Intel Video and Image Processing(VIP)
> + * Frame Buffer II driver

The need for this file confuses me.
It does not include only "of" related stuff, but also generic device driver stuff.

Maybe merge with intel_vip_core.c?
And rename that file to intel_vip_drv.c?

> + *
> + * This driver supports the Intel VIP Frame Reader component.
> + * More info on the hardware can be found in the Intel Video
> + * and Image Processing Suite User Guide at this address
> + * http://www.altera.com/literature/ug/ug_vip.pdf.
> + *
> + * Authors:
> + * Ong, Hean-Loong <hean.loong.ong@intel.com>
> + *
> + */
> +#include <drm/drmP.h>
Drop use of drmP.h

> +static int intelvipfb_of_probe(struct platform_device *pdev)
> +{
> +	int retval;
> +	struct resource *reg_res;
> +	struct intelvipfb_priv *fbpriv;
> +	struct device *dev = &pdev->dev;
> +	struct drm_device *drm;
> +
> +	fbpriv = devm_kzalloc(dev, sizeof(*fbpriv), GFP_KERNEL);
> +	if (!fbpriv)
> +		return -ENOMEM;
> +
> +	/*setup DRM */
Space before "setup"

> +
> +static const struct of_device_id intelvipfb_of_match[] = {
> +	{ .compatible = "altr,vip-frame-buffer-2.0" },
> +	{},
Maybe add "/* sentinel */" comment?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
