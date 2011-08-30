From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 30 Aug 2011 09:17:31 -0700
Subject: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
In-Reply-To: <201108300952.02418.marvin24@gmx.de>
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
	<201108300952.02418.marvin24@gmx.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B3279D49@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Dietich wrote at Tuesday, August 30, 2011 1:52 AM:
...
> > diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
...
> > @@ -95,12 +94,10 @@ static irqreturn_t carddetect_irq(int irq, void *data)
> >
> >  static int tegra_sdhci_8bit(struct sdhci_host *host, int bus_width)
> >  {
> > -	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> > -	struct tegra_sdhci_platform_data *plat;
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct tegra_sdhci_platform_data *plat = pltfm_host->priv;
> >  	u32 ctrl;
> >
> > -	plat = pdev->dev.platform_data;
> > -
> >  	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> >  	if (plat->is_8bit && bus_width == MMC_BUS_WIDTH_8) {
> >  		ctrl &= ~SDHCI_CTRL_4BITBUS;
> 
> what about 8 bit support?

I didn't understand the question at first; I assume you're asking about
8-bit support in the device-tree binding/parsing.

Yes, that's a missing feature, and I should add it. Thanks for pointing
that out.

(I'll also fix the binding docs issue that Shawn pointed out while I'm
at it).

-- 
nvpublic
