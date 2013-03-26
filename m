From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 15:34:55 +0100
Subject: [PATCH 01/11] staging: drm/imx: Add LDB support
In-Reply-To: <1364307246-9017-2-git-send-email-p.zabel@pengutronix.de>
References: <1364307246-9017-1-git-send-email-p.zabel@pengutronix.de>
 <1364307246-9017-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130326153455.5a093e15@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Philipp Zabel,

On Tue, 26 Mar 2013 15:13:56 +0100, Philipp Zabel wrote:

> +/*
> + * For a device declaring compatible = "fsl,imx6q-ldb", "fsl,imx53-ldb",
> + * of_match_device will walk through this list and take the first entry
> + * matching any of its compatible values. Therefore, the more generic
> + * entries (in this case fsl,imx53-ldb) need to be ordered last.
> + */
> +static const struct of_device_id imx_ldb_dt_ids[] = {
> +	{ .compatible = "fsl,imx6q-ldb", .data = imx6q_lvds_mux, },
> +	{ .compatible = "fsl,imx53-ldb", .data = NULL, },
> +	{ }
> +};

You probably want a new DT binding documentation in
Documentation/devicetree/bindings/.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
