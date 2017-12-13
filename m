From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 13 Dec 2017 22:06:29 +0200
Subject: [PATCH v9 2/2] media: i2c: Add the ov7740 image sensor driver
In-Reply-To: <20171211013146.2497-3-wenyou.yang@microchip.com>
References: <20171211013146.2497-1-wenyou.yang@microchip.com>
 <20171211013146.2497-3-wenyou.yang@microchip.com>
Message-ID: <1641aa67-b05e-47e2-600c-70b77571b450@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wenyou,

Wenyou Yang wrote:
...
> +static int ov7740_start_streaming(struct ov7740 *ov7740)
> +{
> +	int ret;
> +
> +	if (ov7740->fmt) {
> +		ret = regmap_multi_reg_write(ov7740->regmap,
> +					     ov7740->fmt->regs,
> +					     ov7740->fmt->reg_num);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (ov7740->frmsize) {
> +		ret = regmap_multi_reg_write(ov7740->regmap,
> +					     ov7740->frmsize->regs,
> +					     ov7740->frmsize->reg_num);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return __v4l2_ctrl_handler_setup(ov7740->subdev.ctrl_handler);

I believe you're still setting the controls after starting streaming.

-- 
Sakari Ailus
sakari.ailus at iki.fi
