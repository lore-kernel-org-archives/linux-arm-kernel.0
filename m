From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 10 Sep 2010 10:58:28 +0100
Subject: [PATCH 6/6] ARM: S5PC110: add support for MMC regulators on
	Goni board
In-Reply-To: <000501cb50ce$5c606f60$15214e20$%kim@samsung.com>
References: <1284103403-10696-1-git-send-email-m.szyprowski@samsung.com>
	<1284103403-10696-7-git-send-email-m.szyprowski@samsung.com>
	<000501cb50ce$5c606f60$15214e20$%kim@samsung.com>
Message-ID: <20100910095828.GE3068@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 10, 2010 at 06:55:50PM +0900, Kukjin Kim wrote:
> > +static struct fixed_voltage_config mmc2_fixed_voltage_config = {
> > +	.supply_name		= "T_FLASH_EN",
> > +	.microvolts		= 2800000,
> > +	.gpio			= S5PV210_MP05(4),	/* XM0ADDR_12 */

...

> >  static void goni_setup_sdhci(void)
> >  {
> > -	gpio_request(GONI_EXT_FLASH_EN, "FLASH_EN");
> > -	gpio_direction_output(GONI_EXT_FLASH_EN, 1);
> > -

> Why need above changes in this patch?
> Others, looks ok.

It looks like ownership of this GPIO has been transferred to the fixed
voltage regulator added in the patch (though using the #define in the
fixed voltage regulator platform data might be a good idea).
