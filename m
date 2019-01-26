Return-Path: <SRS0=wPy5=QC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BCEC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E7021903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 15:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SPJG5qdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E7021903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qCREWHCr3nkp11BWAuRlYIWqJ2QMsSGASBJ9esHnVPE=; b=SPJG5qdZr2q0Si
	pamd0DXES5hJN9MC1zgIJHi5EdiAIBSowWPebI8KOXR6YRUQCCuvMLqrV0NHr9jSroU7u+WQnvrRj
	jj4zC7ViFUA9LiSKUAt+Axa2pfJSchr6oyvv8E7DT2CVF/9K6OllltERzGterST2mtSCDMKc6lmZD
	5Yy79fNcd3AYL3L65t/KMMC9gc3S1KQF5aJ2Qc1ft2e4lVJBXpboq9ZEcVjUo3GX6UwZ5ERjKsdRH
	rUgK1T4yztkRDbdCcktacSjdKXl4e99CGotM8pzCR6zySgSrqYJ4ZR371PS6m6IbsX2SYSxOc00ST
	E0SlEPFVtA2AdcSBTC+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnQ5q-0001fW-U1; Sat, 26 Jan 2019 15:42:02 +0000
Received: from asavdk3.altibox.net ([109.247.116.14])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnQ5l-0000Jm-JE
 for linux-arm-kernel@lists.infradead.org; Sat, 26 Jan 2019 15:42:00 +0000
Received: from ravnborg.org (unknown [158.248.194.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id 2AD1C20025;
 Sat, 26 Jan 2019 16:39:47 +0100 (CET)
Date: Sat, 26 Jan 2019 16:39:46 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 4/4] drm/panel: Add Rondo RB070D30 panel
Message-ID: <20190126153946.GB17756@ravnborg.org>
References: <cover.f7a136448029ab87c498d68164670712639748e7.1548236066.git-series.maxime.ripard@bootlin.com>
 <15b81a58eddd5d3fbfa418293cf1c817ef46423a.1548236066.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <15b81a58eddd5d3fbfa418293cf1c817ef46423a.1548236066.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
 a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
 a=kj9zAlcOel0A:10 a=skhwakB6AAAA:8 a=P-IC7800AAAA:8 a=e5mUnYsNAAAA:8
 a=miUDieqKsZ6B3VLQ9JQA:9 a=CjuIK1q_8ugA:10 a=ygsXHyuYt4xGk45z1DgA:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=Vxmtnl_E_bksehYqCbjh:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190126_074157_995479_78D7C513 
X-CRM114-Status: GOOD (  30.71  )
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
Cc: Konstantin Sudakov <k.sudakov@integrasources.com>, bbrezillon@kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jagan Teki <jagan@openedev.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime / Konstantin.

Nice welstructured and small driver.
Please see a few comments below

Some of the comments in the following apply to a lot of
the existing panel drivers as well.
But lets see if we can get new drivers to be even better.

	Sam 

On Wed, Jan 23, 2019 at 04:54:24PM +0100, Maxime Ripard wrote:
> From: Konstantin Sudakov <k.sudakov@integrasources.com>
> 
> The Rondo RB070D30 panel is a MIPI-DSI panel based on a Fitipower EK79007
> controller and a 1024x600 panel.
> 
> Signed-off-by: Konstantin Sudakov <k.sudakov@integrasources.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                |   9 +-
>  drivers/gpu/drm/panel/Makefile               |   1 +-
>  drivers/gpu/drm/panel/panel-rondo-rb070d30.c | 258 ++++++++++++++++++++-
>  3 files changed, 268 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-rondo-rb070d30.c
> 
> diff --git a/drivers/gpu/drm/panel/panel-rondo-rb070d30.c b/drivers/gpu/drm/panel/panel-rondo-rb070d30.c
> new file mode 100644
> index 000000000000..4f8e63f367b1
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-rondo-rb070d30.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Bridge Systems BV
> + * Copyright (C) 2018, Bootlin
> + * Copyright (C) 2017, Free Electrons
> + *
> + * This file based on panel-ilitek-ili9881c.c
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fb.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drmP.h>
> +#include <drm/drm_panel.h>
Please do not use drmP.h in new drivers. We are trying to get rid of it.

> +
> +#include <video/mipi_display.h>
> +#include <video/of_display_timing.h>
> +#include <video/videomode.h>
> +
> +struct rb070d30_panel {
> +	struct drm_panel panel;
> +	struct mipi_dsi_device *dsi;
> +	struct backlight_device *backlight;
> +	struct regulator *supply;
> +
> +	struct {
> +		struct gpio_desc *power;
> +		struct gpio_desc *reset;
> +		struct gpio_desc *updn;
> +		struct gpio_desc *shlr;
> +	} gpios;
> +};
> +
> +static inline struct rb070d30_panel *panel_to_rb070d30_panel(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct rb070d30_panel, panel);
> +}
> +
> +static int rb070d30_panel_prepare(struct drm_panel *panel)
> +{
> +	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
> +	int ret;
> +
> +	ret = regulator_enable(ctx->supply);
> +	if (ret < 0) {
> +		dev_err(&ctx->dsi->dev, "Failed to enable supply: %d\n", ret);
Use DRM_DEV_ERROR(...) to have consistent error message for the drm drivers.
This is general for the whole file.

> +		return ret;
> +	}
> +
> +	/* Reset */
> +	msleep(20);
> +	gpiod_set_value(ctx->gpios.power, 1);
> +	msleep(20);
> +	gpiod_set_value(ctx->gpios.reset, 1);
> +	msleep(20);
> +	return 0;
> +}
To verify the above pointer to a datasheet would be nice.


> +
> +static int rb070d30_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
> +
> +	gpiod_set_value(ctx->gpios.power, 0);
> +	gpiod_set_value(ctx->gpios.reset, 0);
> +	regulator_disable(ctx->supply);
> +
> +	return 0;
> +}
There is sometimes timing constrains after deassert reset..
The order is not strictly reverse of prepare - is that on purpose?


> +
> +static int rb070d30_panel_enable(struct drm_panel *panel)
> +{
> +	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
> +	int ret;
> +
> +	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> +	if (ret)
> +		return ret;
> +
> +	ret = backlight_enable(ctx->backlight);
> +	if (ret)
> +		goto out;
> +
> +	return 0;
> +
> +out:
> +	mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +	return ret;
> +}
> +
> +static int rb070d30_panel_disable(struct drm_panel *panel)
> +{
> +	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
> +
> +	backlight_disable(ctx->backlight);
> +	return mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +}
> +
> +/* Default timings */
> +static const struct drm_display_mode default_mode = {
> +	.clock		= 51206,
> +	.hdisplay	= 1024,
> +	.hsync_start	= 1024 + 160,
> +	.hsync_end	= 1024 + 160 + 80,
> +	.htotal		= 1024 + 160 + 80 + 80,
> +	.vdisplay	= 600,
> +	.vsync_start	= 600 + 12,
> +	.vsync_end	= 600 + 12 + 10,
> +	.vtotal		= 600 + 12 + 10 + 13,
> +	.vrefresh	= 60,
> +};
height and width missing here. Seems better to add them here than hiding in code below.
Is it on purpose that no flags are specified?

> +
> +static int rb070d30_panel_get_modes(struct drm_panel *panel)
> +{
> +	struct drm_connector *connector = panel->connector;
> +	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
> +	struct drm_display_mode *mode;
> +	static const u32 bus_format = MEDIA_BUS_FMT_RGB888_1X24;
> +
> +	mode = drm_mode_duplicate(panel->drm, &default_mode);
> +	if (!mode) {
> +		dev_err(&ctx->dsi->dev, "failed to add mode %ux%ux@%u\n",
> +			default_mode.hdisplay, default_mode.vdisplay,
> +			default_mode.vrefresh);
Use"
		DRM_DEV_ERROR(&ctx->dsi->dev,
			      "failed to add mode" DRM_MODE_FMT,
			      DRM_MODE_ARG(mode));
> +		return -EINVAL;
> +	}
> +
> +	drm_mode_set_name(mode);
> +
> +	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> +	drm_mode_probed_add(connector, mode);
> +
> +	panel->connector->display_info.bpc = 8;
> +	panel->connector->display_info.width_mm = 154;
> +	panel->connector->display_info.height_mm = 85;
See comment on height above.
Same goes for bpc

> +	drm_display_info_set_bus_formats(&connector->display_info,
> +					 &bus_format, 1);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs rb070d30_panel_funcs = {
> +	.get_modes	= rb070d30_panel_get_modes,
> +	.prepare	= rb070d30_panel_prepare,
> +	.enable		= rb070d30_panel_enable,
> +	.disable	= rb070d30_panel_disable,
> +	.unprepare	= rb070d30_panel_unprepare,
> +};
> +
> +static int rb070d30_panel_dsi_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct device_node *np;
> +	struct rb070d30_panel *ctx;
> +	int ret;
> +
> +	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->supply = devm_regulator_get(&dsi->dev, "vcc-lcd");
> +	if (IS_ERR(ctx->supply))
> +		return PTR_ERR(ctx->supply);
> +
> +	mipi_dsi_set_drvdata(dsi, ctx);
> +	ctx->dsi = dsi;
> +
> +	drm_panel_init(&ctx->panel);
> +	ctx->panel.dev = &dsi->dev;
> +	ctx->panel.funcs = &rb070d30_panel_funcs;
> +
> +	ctx->gpios.reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->gpios.reset)) {
> +		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
> +		return PTR_ERR(ctx->gpios.reset);
> +	}
> +
> +	ctx->gpios.power = devm_gpiod_get(&dsi->dev, "power", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->gpios.power)) {
> +		dev_err(&dsi->dev, "Couldn't get our power GPIO\n");
> +		return PTR_ERR(ctx->gpios.power);
> +	}
> +
> +	ctx->gpios.updn = devm_gpiod_get(&dsi->dev, "updn", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->gpios.updn)) {
> +		dev_err(&dsi->dev, "Couldn't get our updn GPIO\n");
> +		return PTR_ERR(ctx->gpios.updn);
> +	}
This gpio is never used, it is only read from DT


> +
> +	ctx->gpios.shlr = devm_gpiod_get(&dsi->dev, "shlr", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->gpios.shlr)) {
> +		dev_err(&dsi->dev, "Couldn't get our shlr GPIO\n");
> +		return PTR_ERR(ctx->gpios.shlr);
> +	}
This gpio is never used, it is only read from DT

> +
> +	np = of_parse_phandle(dsi->dev.of_node, "backlight", 0);
> +	if (np) {
> +		ctx->backlight = of_find_backlight_by_node(np);
> +		of_node_put(np);
> +
> +		if (!ctx->backlight)
> +			return -EPROBE_DEFER;
> +	}
Use devm_of_find_backlight()

> +
> +	ret = drm_panel_add(&ctx->panel);
> +	if (ret < 0)
> +		goto free_backlight;
> +
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->lanes = 4;
> +
> +	return mipi_dsi_attach(dsi);
> +
> +free_backlight:
> +	backlight_put(ctx->backlight);
If devm_of_find_backlight() is used this can go.

> +	return ret;
> +}
> +
> +static int rb070d30_panel_dsi_remove(struct mipi_dsi_device *dsi)
> +{
> +	struct rb070d30_panel *ctx = mipi_dsi_get_drvdata(dsi);
> +
> +	mipi_dsi_detach(dsi);
> +	drm_panel_remove(&ctx->panel);
> +	backlight_put(ctx->backlight);
If devm_of_find_backlight() is used this can go.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rb070d30_panel_of_match[] = {
> +	{ .compatible = "rondo,rb070d30" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, rb070d30_panel_of_match);
> +
> +static struct mipi_dsi_driver rb070d30_panel_driver = {
> +	.probe = rb070d30_panel_dsi_probe,
> +	.remove = rb070d30_panel_dsi_remove,
> +	.driver = {
> +		.name = "panel-rondo-rb070d30",
> +		.of_match_table	= rb070d30_panel_of_match,
> +	},
> +};
> +module_mipi_dsi_driver(rb070d30_panel_driver);
> +
> +MODULE_AUTHOR("Boris Brezillon <boris.brezillon@bootlin.com>");
> +MODULE_AUTHOR("Konstantin Sudakov <k.sudakov@integrasources.com>");
> +MODULE_DESCRIPTION("Rondo RB070D30 Panel Driver");
> +MODULE_LICENSE("GPL");
> -- 
> git-series 0.9.1
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
