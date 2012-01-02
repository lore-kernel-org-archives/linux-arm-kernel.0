From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 11:45:59 +0000
Subject: [RFC][PATCH 2/4] lcd: platform-lcd: Add support for Hydis
 hv070wsa lcd panel
In-Reply-To: <1325483675-21908-3-git-send-email-thomas.abraham@linaro.org>
References: <1325483675-21908-1-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-2-git-send-email-thomas.abraham@linaro.org>
 <1325483675-21908-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120102114559.GE2899@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 11:24:33AM +0530, Thomas Abraham wrote:

> +static void lcd_hv070wsa_set_power(struct platform_lcd *plcd, unsigned int pwr)
> +{
> +	struct plat_lcd_hydis_hv070wsa_pdata *pdata = plcd->lcd_pdata;
> +
> +	gpio_direction_output(pdata->gpio, pwr);
> +}

This doesn't look at all specific to this panel - it's just setting a
GPIO - so it should probably just be a generic gpio-lcd driver (or
similar).  It ought to be possible to do a device tree binding for at
least this subset of panels.
