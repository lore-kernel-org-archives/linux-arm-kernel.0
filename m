From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jun 2012 01:56:52 -0700
Subject: [PATCH 6/9] ARM: OMAP2+: gpmc-smsc911x: Adapt to use gpmc driver
In-Reply-To: <fa4fd074305f914d38603443b857422f95680725.1339419379.git.afzal@ti.com>
References: <cover.1339419379.git.afzal@ti.com>
 <fa4fd074305f914d38603443b857422f95680725.1339419379.git.afzal@ti.com>
Message-ID: <20120614085650.GD12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120611 08:20]:
> +__init gpmc_smsc911x_update(struct omap_smsc911x_platform_data *gpmc_cfg)
> +{
> +	int ret;
> +	struct gpmc_device_pdata *gpmc_pdev;
> +	struct gpmc_cs_data *gpmc_cs;
> +
> +	gpmc_pdev = kzalloc(sizeof(*gpmc_pdev), GFP_KERNEL);
> +	if (gpmc_pdev == NULL)
> +		return gpmc_pdev;
> +
> +	gpmc_cs = kzalloc(sizeof(*gpmc_cs), GFP_KERNEL);
> +	if (gpmc_pdev == NULL) {
> +		kfree(gpmc_pdev);
> +		return NULL;
> +	}

Here your should check for if (!gpmc_cs), not gpmc_cs. Might
be worth checking all your patches for similar copy and paste
typos.

Where do gpmc_pdev and gpmc_cs get used? Where are they
stored to the pdata?

Tony
