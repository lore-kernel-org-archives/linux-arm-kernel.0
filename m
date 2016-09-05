From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Sep 2016 09:07:16 +0200
Subject: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160905070716.GA6322@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nitpicks ahead.

On Thu, Sep 01, 2016 at 04:05:05PM +0200, Quentin Schulz wrote:
> +	info->soc_specific = (struct soc_specific *)platform_get_device_id(pdev)->driver_data;

This line is still rather long. How about calling the field "data" and
the structure gpadc_data?

> +
> +	tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,
> +						   &sun4i_ts_tz_ops);

A comment on why you put the parent device structure and not the
device itself like you're doing on all the other calls in that probe
would be nice.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160905/6ec36d05/attachment.sig>
