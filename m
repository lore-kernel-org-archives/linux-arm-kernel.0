From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 25 May 2011 08:46:19 +0200
Subject: [PATCH v2 5/7] mmc: sdhci: consolidate sdhci-of-esdhc and
	sdhci-esdhc-imx
In-Reply-To: <20110525060637.GA30583@S2100-06.ap.freescale.net>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
	<1304601778-13837-6-git-send-email-shawn.guo@linaro.org>
	<20110524194054.GC25727@pengutronix.de>
	<20110525060637.GA30583@S2100-06.ap.freescale.net>
Message-ID: <20110525064619.GI9774@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

> > > +#ifndef CONFIG_MMC_SDHCI_ESDHC_IMX
> > > +#define cpu_is_mx25()	(0)
> > > +#define cpu_is_mx35()	(0)
> > > +#define cpu_is_mx51()	(0)
> > > +#define cpu_is_imx()	(0)
> > > +#else
> > > +#define cpu_is_imx()	(1)
> > > +#endif
> > 
> > ... e.g. that looks a bit frightening.
> > 
> Agree.
> 
> The use of cpu_is_mx..() in the driver itself seems a churn to me
> even without this consolidation patch.  Is it possible for us to
> eliminate them by using pdata, and eventually device tree?  When we
> are there, I might want to revisit the consolidation again.
An alternative that allows letting the logic in the driver and still
getting rid of the cpu_is_ stuff is using platform ids. See
drivers/spi/spi_imx.c for an example. Instead of an index into an array
(as it's for the imx-spi driver) driver_data can hold flags, too, which
should be enough most of the time.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
