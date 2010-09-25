From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Sep 2010 17:38:59 -0700
Subject: [PATCH v4 1/4] omap4 hsmmc: Adding card detect support for MMC1
In-Reply-To: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
References: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
Message-ID: <20100925003859.GR4211@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* kishore kadiyala <kishore.kadiyala@ti.com> [100924 10:05]:
> Adding card detect callback function and card detect configuration
> function for MMC1 Controller on OMAP4.
> 
> Card detect configuration function does initial configuration of the
> MMC Control & PullUp-PullDown registers of Phoenix.
> 
> For MMC1 Controller, card detect interrupt source is
> twl6030 which is non-gpio. The card detect call back function provides
> card present/absent status by reading MMC Control register present
> on twl6030.
> 
> Since OMAP4 doesn't use any GPIO line as used in OMAP3 for card detect,
> the suspend/resume initialization which was done in omap_hsmmc_gpio_init
> previously is moved to the probe thus making it generic for both OMAP3 & OMAP4.

> --- a/drivers/mfd/twl6030-irq.c
> +++ b/drivers/mfd/twl6030-irq.c

Looks like this patch should be sent to Samuel Ortiz as it's mostly
mfd related.

Tony
