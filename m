From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Jun 2014 08:40:38 +0200
Subject: [PATCH 1/5] mmc: sdhci-esdhc-imx: add f_max field to private data
In-Reply-To: <20140601074540.GC11061@dragon>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-2-git-send-email-s.hauer@pengutronix.de>
 <20140601074540.GC11061@dragon>
Message-ID: <20140602064038.GP15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 01, 2014 at 03:45:43PM +0800, Shawn Guo wrote:
> > @@ -594,7 +592,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
> >  {
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
> > -	unsigned int host_clock = pltfm_host->clock;
> > +	unsigned int host_clock = clk_get_rate(imx_data->clk_per);
> 
> Will this bring the issue that commit a974862faee1 (mmc: sdhci-esdhc-imx:
> fix access hardirq-unsafe lock in atomic context) fixed back to us?

Probably, yes, because the ?%$&"$$ sdhc driver still uses spinlocks.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
