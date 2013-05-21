From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 May 2013 20:23:03 +0200
Subject: [PATCH V2 1/2] ARM: mmc: bcm281xx SDHCI driver
In-Reply-To: <519B2EAD.4000208@broadcom.com>
References: <1368200883-15668-1-git-send-email-csd@broadcom.com>
 <201305170009.46244.arnd@arndb.de> <519B2EAD.4000208@broadcom.com>
Message-ID: <201305212023.03272.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 May 2013, Christian Daudt wrote:
> >> +    cfg = devm_kzalloc(&pdev->dev, sizeof(*cfg), GFP_KERNEL);
> >> +    if (!cfg) {
> >> +            dev_err(&pdev->dev, "Can't allocate platform cfg\n");
> >> +            return NULL;
> >> +    }
> > Not needed
> what is not needed ?

The allocation, it can be part of the sdhci_pltfm_host data.

> >> +    const struct sdhci_pltfm_data *plat_data;
> > make it global.
> why make this global ?

Sorry for being unclear. I mean you can just use &sdhci_pltfm_data_kona
in the probe function, since the data is constant anyway, no need to have
a local variable for pulling this out of the device id.

	Arnd
