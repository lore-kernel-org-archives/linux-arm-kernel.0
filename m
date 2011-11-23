From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 09:29:24 -0800
Subject: [alsa-devel] [PATCH 07/17] ASoC: Tegra DAS: Use devm_ APIs and
 module_platform_driver
In-Reply-To: <20111123065808.GB5255@avionic-0098.adnet.avionic-design.de>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-8-git-send-email-swarren@nvidia.com>
 <20111123065808.GB5255@avionic-0098.adnet.avionic-design.de>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6F3@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding wrote at Tuesday, November 22, 2011 11:58 PM:
> * Stephen Warren wrote:
> > module_platform_drive saves some boiler-plate code.
> >
> > The devm_ APIs remove the need to manually clean up allocations,
> > thus removing some code.
...
> >  static int __devexit tegra_das_remove(struct platform_device *pdev)
> >  {
> > -	struct resource *res;
> > -
> >  	if (!das)
> >  		return -ENODEV;
> >
> > -	platform_set_drvdata(pdev, NULL);
> > -
> [...]
> 
> Setting the driver data to NULL may still be a good idea.

When Mark Brown reviewed the TrimSlice machine driver, he mentioned that
clearing the drvdata was pointless; nothing should be using it when the
device is not created.

As background, soon after that, I modified the tegra_wm8903.c machine
driver along the same lines, but evidently didn't update tegra_das.c
in a similar way, but would have if I'd been paying attention...

-- 
nvpublic
