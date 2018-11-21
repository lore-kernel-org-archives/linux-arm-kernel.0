From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 21 Nov 2018 11:11:21 +0100
Subject: [PATCH v2 8/9] phy: Add Cadence D-PHY support
In-Reply-To: <8536050b-40ab-1ec4-d325-e59bb3a92e73@ti.com>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <4ec9e47fb5aa9794f69a8e75a04108055094c056.1541516029.git-series.maxime.ripard@bootlin.com>
 <5f5bcc06-51b2-d565-56a0-083c66c1f01a@ti.com>
 <8536050b-40ab-1ec4-d325-e59bb3a92e73@ti.com>
Message-ID: <20181121101121.7rhe2hz2mnmc72cu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Tue, Nov 20, 2018 at 11:02:34AM +0530, Kishon Vijay Abraham I wrote:
> > > +static int cdns_dphy_config_from_opts(struct phy *phy,
> > > +				      struct phy_configure_opts_mipi_dphy *opts,
> > > +				      struct cdns_dphy_cfg *cfg)
> > > +{
> > > +	struct cdns_dphy *dphy = phy_get_drvdata(phy);
> > > +	unsigned int dsi_hfp_ext = 0;
> > > +	int ret;
> > > +
> > > +	ret = phy_mipi_dphy_config_validate(opts);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = cdns_dsi_get_dphy_pll_cfg(dphy, cfg,
> > > +					opts, &dsi_hfp_ext);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	opts->wakeup = cdns_dphy_get_wakeup_time_ns(dphy);
> 
> Is the wakeup populated here used by the consumer driver?

It's supposed to, if it can yes.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181121/ac58d85e/attachment.sig>
