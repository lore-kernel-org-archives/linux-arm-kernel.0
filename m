From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 20 May 2014 16:06:52 +0200
Subject: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <1821771.zFvTDGF2Ae@amdc1032>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <1821771.zFvTDGF2Ae@amdc1032>
Message-ID: <20140520140652.GB21579@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 20, 2014 at 02:34:20PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday, May 20, 2014 11:04:29 AM Antoine T?nart wrote:
> > +
> > +static struct phy_berlin_desc desc[] = {
> > +	{ .val = POWER_DOWN_PHY0 },
> > +	{ .val = POWER_DOWN_PHY1 },
> 
> Only .val entry of struct phy_berlin_desc is initialized and needed,
> it seems that u32 vals[] should be used instead of desc[].

Sure.

> > +
> > +static int phy_berlin_sata_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct phy *phy;
> > +	struct phy_provider *phy_provider;
> > +	struct phy_berlin_priv *priv;
> > +	struct resource *res;
> > +	int i;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	priv->base = devm_ioremap(dev, res->start, resource_size(res));
> > +	if (IS_ERR(priv->base))
> > +		return PTR_ERR(priv->base);
> 
> devm_ioremap() (contrary to devm_ioremap_resource()) returns a valid
> pointer or NULL so return value checking should be fixed.

I'll fix this.


Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
