From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 12 Mar 2012 16:17:02 +0100
Subject: [PATCH] stmmac: Add device-tree support
In-Reply-To: <201203121625.50283.sr@denx.de>
References: <1331561157-3820-1-git-send-email-sr@denx.de>
 <20120312143825.GB13869@game.jcrosoft.org>
 <201203121625.50283.sr@denx.de>
Message-ID: <20120312151702.GD13869@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:25 Mon 12 Mar     , Stefan Roese wrote:
> On Monday 12 March 2012 15:38:25 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > @@ -58,6 +94,22 @@ static int stmmac_pltfr_probe(struct platform_device
> > > *pdev)
> > > 
> > >  		ret = -ENOMEM;
> > >  		goto out_release_region;
> > >  	
> > >  	}
> > > 
> > > +
> > > +#ifdef CONFIG_OF
> > > +	plat_dat = devm_kzalloc(&pdev->dev, sizeof(struct
> > > plat_stmmacenet_data), +				GFP_KERNEL);
> > > +	if (!plat_dat) {
> > > +		pr_err("%s: ERROR: no memory", __func__);
> > > +		ret = -ENOMEM;
> > > +		goto out_unmap;
> > > +	}
> > > +
> > > +	ret = stmmac_probe_config_dt(pdev, plat_dat, &mac);
> > > +	if (ret) {
> > > +		pr_err("%s: main dt probe failed", __func__);
> > > +		goto out_unmap;
> > > +	}
> > > +#else
> > 
> > This must be check at runtime, we can boot a kernel with or without DT.
> 
> Are you referring to using "if (pdev->dev.of_node)" to distinguish between DT 
> and non-DT version instead of this #ifdef?
yes

Best Regards,
J.
