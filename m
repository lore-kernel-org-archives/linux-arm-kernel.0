Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FDAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:00:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D67218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ga49sLui";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="PrEM7YxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D67218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vanguardiasur.com.ar
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7CWE4jXaZGNcxHB/SZSzvPvvOsMlPsnrgWFbnfdS4Go=; b=ga49sLuiMi2EDO
	zR1U+gB3RTVEOCQdkuITD8A6xgVFFQqG7plaH4s/mc+FBXrLmELV5DV9MCq1iC0s3d78pcsJybjVv
	6QVwEuj6yLOvh0mjj1WPuKpHEakq9LmkIfYbYBqnQrLiyvUCxxfEEMH+rXCpoGWWeWdY9ayhX3vvk
	y0b7BU2Q6TFaYWaUWw+3dXRbwCvpBB4+/5jLB4nVim46P6z/kOezW6/Ce8KgMQ6hufaUkx91g10vu
	WcXo6g9M+FrNKp9VtxQeHc+gHDMOChZOLux/VHWtM1fZneL5Jt5GDlof5Vj39p072b48AiYfQiM66
	CrnvdcfUoDG8HB4GkPCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grWAn-0007pm-4u; Wed, 06 Feb 2019 23:00:05 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grWAg-0007X9-O1
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 23:00:00 +0000
Received: by mail-vs1-xe43.google.com with SMTP id x1so5530366vsc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 14:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uXH9a2dppdpSNAGK0f8SWpctS4xZNg2ypeaL9mfYgoY=;
 b=PrEM7YxKxgYWN/NkcaFXH+B1fOUI9tOO/9jKglnXwzcsJR2ngPHLIGHvl3+J+XXpnj
 vxGSU/73gD9/y98ZB4tQKI/cHMNUB5dZA1T5C6FU6ZZx9pfX+fQGIfs1+oxomURERuW0
 e3kapAMluAIUBoRdeBmHWhbbaMai8fx/KTVujsZiZ8/m1rXLM6zrMx9QwmXwBviao7JR
 YaMc8IxZm4Gcoe2DmeFzM+iCVduoUxjqqN5RPRn0Tk3Gxw5pJpD1MDfzoorMhi6CAAZX
 Uq3KK9vRKXOzDgWjIgQLx5R7wWQM2BxVPwutltCaUxyhrTSMIkw5gLh2GMX65oDhN/9q
 KOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uXH9a2dppdpSNAGK0f8SWpctS4xZNg2ypeaL9mfYgoY=;
 b=rra3+ZkE6YJGz2RaFMV6+c3VjRK/21YzeA3fBGD4ykveJcKXsPPnzWJlINkmmcki4m
 U9qsJ++jROkwEzQ9+xnSUUIR6Y1iMcK8ypCqY7FWVlXsP3TtNhkoDEZPo/8a5Sf0apvj
 vUwScrLTpQ1klW/J3wNaz/snxSE4dVpS4lhmg1BILL9EgMWT5OXmk/AiIY/Z687EWZu2
 JGzzjhIzb2IHou3wbBafXfLRzCUilbbGdGYFKsNZwaUvc9qwusAGw7k+sBayyegOrh0N
 8Lqv7ngvxPtpWIKMO2qA7v33h+qXJi8GEk3IO6jMn12XEktaP9uto+Vjp7Kco/GygA19
 R/mg==
X-Gm-Message-State: AHQUAubiPIx9HlIUX5wGlZ67pePIvQ14q6zHKyQdqdwe82pjJOF+cjlT
 /pEgxj1Bwyd5nvKJ+/yNlUIZfGWlx0q7OFtYi7q9AQ==
X-Google-Smtp-Source: AHgI3IZQ2RXu2sClg9a8t6oN4ckj8Ve3ttJSZx4yW6qQivAmVgPIfWj0B3j5rb0jXX2umuBwY9v64qUybbl6XgVaX+M=
X-Received: by 2002:a67:b245:: with SMTP id s5mr5179586vsh.200.1549493994583; 
 Wed, 06 Feb 2019 14:59:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.ba7411f0c7155d0292b38d3dec698e26b5cc813b.1548687041.git-series.maxime.ripard@bootlin.com>
 <c1a7d46f8504decb58ff224b0b5f2f0733282cc6.1548687041.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <c1a7d46f8504decb58ff224b0b5f2f0733282cc6.1548687041.git-series.maxime.ripard@bootlin.com>
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Wed, 6 Feb 2019 19:59:43 -0300
Message-ID: <CAAEAJfAxWBvj6E1fJ8fy=F2xDXLHwRq7-2BT3tQqbPvbZxseyg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] media: sunxi: Add A10 CSI driver
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_145959_222930_B416A270 
X-CRM114-Status: GOOD (  23.88  )
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
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 28 Jan 2019 at 11:53, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The older CSI drivers have camera capture interface different from the one
> in the newer ones.
>
> This IP is pretty simple. Some variants (one controller out of two
> instances on some SoCs) have an ISP embedded, but there's no code that make
> use of it, so we ignored that part for now.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  MAINTAINERS                                         |   8 +-
>  drivers/media/platform/sunxi/Kconfig                |   1 +-
>  drivers/media/platform/sunxi/Makefile               |   1 +-
>  drivers/media/platform/sunxi/sun4i-csi/Kconfig      |  12 +-
>  drivers/media/platform/sunxi/sun4i-csi/Makefile     |   5 +-
>  drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c  | 261 ++++++++-
>  drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h  | 142 ++++-
>  drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c  | 435 +++++++++++++-
>  drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c | 305 +++++++++-
>  9 files changed, 1170 insertions(+)
>  create mode 100644 drivers/media/platform/sunxi/sun4i-csi/Kconfig
>  create mode 100644 drivers/media/platform/sunxi/sun4i-csi/Makefile
>  create mode 100644 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
>  create mode 100644 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.h
>  create mode 100644 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
>  create mode 100644 drivers/media/platform/sunxi/sun4i-csi/sun4i_v4l2.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32d444476a90..5f703ed9adb1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1295,6 +1295,14 @@ F:       drivers/pinctrl/sunxi/
>  F:     drivers/soc/sunxi/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
>
> +Allwinner A10 CSI driver
> +M:     Maxime Ripard <maxime.ripard@bootlin.com>
> +L:     linux-media@vger.kernel.org
> +T:     git git://linuxtv.org/media_tree.git
> +S:     Maintained
> +F:     drivers/media/platform/sunxi/sun4i-csi/
> +F:     Documentation/devicetree/bindings/media/sun4i-csi.txt
> +
>  ARM/Amlogic Meson SoC CLOCK FRAMEWORK
>  M:     Neil Armstrong <narmstrong@baylibre.com>
>  M:     Jerome Brunet <jbrunet@baylibre.com>
> diff --git a/drivers/media/platform/sunxi/Kconfig b/drivers/media/platform/sunxi/Kconfig
> index 1b6e89cb78b2..71808e93ac2e 100644
> --- a/drivers/media/platform/sunxi/Kconfig
> +++ b/drivers/media/platform/sunxi/Kconfig
> @@ -1 +1,2 @@
> +source "drivers/media/platform/sunxi/sun4i-csi/Kconfig"
>  source "drivers/media/platform/sunxi/sun6i-csi/Kconfig"
> diff --git a/drivers/media/platform/sunxi/Makefile b/drivers/media/platform/sunxi/Makefile
> index 8d06f98500ee..a05127529006 100644
> --- a/drivers/media/platform/sunxi/Makefile
> +++ b/drivers/media/platform/sunxi/Makefile
> @@ -1 +1,2 @@
> +obj-y          += sun4i-csi/
>  obj-y          += sun6i-csi/
> diff --git a/drivers/media/platform/sunxi/sun4i-csi/Kconfig b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
> new file mode 100644
> index 000000000000..841a6f4d9c99
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
> @@ -0,0 +1,12 @@
> +config VIDEO_SUN4I_CSI
> +       tristate "Allwinner A10 CMOS Sensor Interface Support"
> +       depends on VIDEO_DEV && VIDEO_V4L2 && HAS_DMA
> +       depends on ARCH_SUNXI || COMPILE_TEST
> +       select VIDEOBUF2_DMA_CONTIG
> +       select V4L2_FWNODE
> +       select V4L2_MEM2MEM_DEV
> +       help
> +         This is a V4L2 driver for the Allwinner A10 CSI
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called sun4i_csi.
> diff --git a/drivers/media/platform/sunxi/sun4i-csi/Makefile b/drivers/media/platform/sunxi/sun4i-csi/Makefile
> new file mode 100644
> index 000000000000..7c790a57f5ee
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun4i-csi/Makefile
> @@ -0,0 +1,5 @@
> +sun4i-csi-y += sun4i_csi.o
> +sun4i-csi-y += sun4i_dma.o
> +sun4i-csi-y += sun4i_v4l2.o
> +
> +obj-$(CONFIG_VIDEO_SUN4I_CSI)  += sun4i-csi.o
> diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
> new file mode 100644
> index 000000000000..9b58b42c0043
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c
> @@ -0,0 +1,261 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 NextThing Co
> + * Copyright (C) 2016-2018 Bootlin
> + *
> + * Author: Maxime Ripard <maxime.ripard@bootlin.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/videodev2.h>
> +
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-mediabus.h>
> +
> +#include <media/videobuf2-core.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "sun4i_csi.h"
> +
> +static int csi_notify_bound(struct v4l2_async_notifier *notifier,
> +                           struct v4l2_subdev *subdev,
> +                           struct v4l2_async_subdev *asd)
> +{
> +       struct sun4i_csi *csi = container_of(notifier, struct sun4i_csi,
> +                                            notifier);
> +
> +       csi->src_subdev = subdev;
> +       csi->src_pad = media_entity_get_fwnode_pad(&subdev->entity,
> +                                                  subdev->fwnode,
> +                                                  MEDIA_PAD_FL_SOURCE);
> +       if (csi->src_pad < 0) {
> +               dev_err(csi->dev, "Couldn't find output pad for subdev %s\n",
> +                       subdev->name);
> +               return csi->src_pad;
> +       }
> +
> +       dev_dbg(csi->dev, "Bound %s pad: %d\n", subdev->name, csi->src_pad);
> +       return 0;
> +}
> +
> +static int csi_notify_complete(struct v4l2_async_notifier *notifier)
> +{
> +       struct sun4i_csi *csi = container_of(notifier, struct sun4i_csi,
> +                                            notifier);
> +       int ret;
> +
> +       ret = v4l2_device_register_subdev_nodes(&csi->v4l);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = sun4i_csi_v4l2_register(csi);
> +       if (ret < 0)
> +               return ret;
> +
> +       return media_create_pad_link(&csi->src_subdev->entity, csi->src_pad,
> +                                    &csi->vdev.entity, 0,
> +                                    MEDIA_LNK_FL_ENABLED |
> +                                    MEDIA_LNK_FL_IMMUTABLE);
> +}
> +
> +static const struct v4l2_async_notifier_operations csi_notify_ops = {
> +       .bound          = csi_notify_bound,
> +       .complete       = csi_notify_complete,
> +};
> +
> +static int sun4i_csi_async_parse(struct device *dev,
> +                                struct v4l2_fwnode_endpoint *vep,
> +                                struct v4l2_async_subdev *asd)
> +{
> +       struct sun4i_csi *csi = dev_get_drvdata(dev);
> +
> +       if (vep->base.port || vep->base.id)
> +               return -EINVAL;
> +
> +       if (vep->bus_type != V4L2_MBUS_PARALLEL)
> +               return -EINVAL;
> +
> +       csi->bus = vep->bus.parallel;
> +
> +       return 0;
> +}
> +
> +static int csi_probe(struct platform_device *pdev)
> +{
> +       struct sun4i_csi *csi;
> +       struct resource *res;
> +       int ret;
> +       int irq;
> +
> +       csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
> +       if (!csi)
> +               return -ENOMEM;
> +       platform_set_drvdata(pdev, csi);
> +       csi->dev = &pdev->dev;
> +
> +       csi->mdev.dev = csi->dev;
> +       strscpy(csi->mdev.model, "Allwinner Video Capture Device",
> +               sizeof(csi->mdev.model));
> +       csi->mdev.hw_revision = 0;
> +       media_device_init(&csi->mdev);
> +       v4l2_async_notifier_init(&csi->notifier);
> +
> +       csi->pad.flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
> +       ret = media_entity_pads_init(&csi->vdev.entity, 1, &csi->pad);
> +       if (ret < 0)
> +               return 0;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       csi->regs = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(csi->regs))
> +               return PTR_ERR(csi->regs);
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       csi->bus_clk = devm_clk_get(&pdev->dev, "bus");
> +       if (IS_ERR(csi->bus_clk)) {
> +               dev_err(&pdev->dev, "Couldn't get our bus clock\n");
> +               return PTR_ERR(csi->bus_clk);
> +       }
> +
> +       csi->isp_clk = devm_clk_get(&pdev->dev, "isp");
> +       if (IS_ERR(csi->isp_clk)) {
> +               dev_err(&pdev->dev, "Couldn't get our ISP clock\n");
> +               return PTR_ERR(csi->isp_clk);
> +       }
> +
> +       csi->mod_clk = devm_clk_get(&pdev->dev, "mod");
> +       if (IS_ERR(csi->mod_clk)) {
> +               dev_err(&pdev->dev, "Couldn't get our mod clock\n");
> +               return PTR_ERR(csi->mod_clk);
> +       }
> +
> +       csi->ram_clk = devm_clk_get(&pdev->dev, "ram");
> +       if (IS_ERR(csi->ram_clk)) {
> +               dev_err(&pdev->dev, "Couldn't get our ram clock\n");
> +               return PTR_ERR(csi->ram_clk);
> +       }
> +

Minor comment: perhaps you can take advantage
of the clock bulk API and simplify the clock management.

Regards,
Ezequiel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
