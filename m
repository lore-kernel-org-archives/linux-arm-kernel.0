From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 14 Jan 2015 17:02:56 -0800
Subject: [PATCH v2 1/2] Input: touchscreen-iproc: Add Broadcom iProc
 touchscreen driver
In-Reply-To: <1419027470-7969-2-git-send-email-jonathar@broadcom.com>
References: <jonathar@broadcom.com>
 <1419027470-7969-1-git-send-email-jonathar@broadcom.com>
 <1419027470-7969-2-git-send-email-jonathar@broadcom.com>
Message-ID: <20150115010256.GC9134@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Fri, Dec 19, 2014 at 02:17:49PM -0800, Jonathan Richardson wrote:
> +	if (of_property_read_u32(np, "scanning_period", &val) >= 0) {
> +		if (val < 1 || val > 256) {
> +			dev_err(dev, "scanning_period must be [1-256]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.scanning_period = val;
> +	}
> +
> +	if (of_property_read_u32(np, "debounce_timeout", &val) >= 0) {
> +		if (val < 0 || val > 255) {
> +			dev_err(dev, "debounce_timeout must be [0-255]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.debounce_timeout = val;
> +	}
> +
> +	if (of_property_read_u32(np, "settling_timeout", &val) >= 0) {
> +		if (val < 0 || val > 11) {
> +			dev_err(dev, "settling_timeout must be [0-11]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.settling_timeout = val;
> +	}
> +
> +	if (of_property_read_u32(np, "touch_timeout", &val) >= 0) {
> +		if (val < 0 || val > 255) {
> +			dev_err(dev, "touch_timeout must be [0-255]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.touch_timeout = val;
> +	}
> +
> +	if (of_property_read_u32(np, "average_data", &val) >= 0) {
> +		if (val < 0 || val > 8) {
> +			dev_err(dev, "average_data must be [0-8]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.average_data = val;
> +	}
> +
> +	if (of_property_read_u32(np, "fifo_threshold", &val) >= 0) {
> +		if (val < 0 || val > 31) {
> +			dev_err(dev, "fifo_threshold must be [0-31]\n");
> +			return -EINVAL;
> +		}
> +		priv->cfg_params.fifo_threshold = val;
> +	}

I think these are dveice specific and thus should have "brcm," prefix.

> +
> +	priv->ts_rotation = TS_ROTATION_0;
> +	if (of_property_read_u32(np, "ts-rotation", &val) >= 0) {
> +		priv->ts_rotation = val;
> +		dev_dbg(dev, "ts rotation [%d] degrees\n",
> +			90 * priv->ts_rotation);
> +	}

This I am not quite sure about - if we want rotation or swap+invert. You
are CCed on another email (tsc2007) that talks about need of generic
touchscreen transforms in input core/of bindings.

Thanks.

-- 
Dmitry
