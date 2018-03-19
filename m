From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Mon, 19 Mar 2018 09:45:23 +0100
Subject: [PATCH net-next 03/10] net: mvpp2: phylink support
In-Reply-To: <20180316160322.GR9418@n2100.armlinux.org.uk>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-4-antoine.tenart@bootlin.com>
 <20180316160322.GR9418@n2100.armlinux.org.uk>
Message-ID: <20180319084523.GE4519@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Mar 16, 2018 at 04:03:22PM +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 16, 2018 at 11:33:44AM +0100, Antoine Tenart wrote:
> > +static void mvpp2_phylink_validate(struct net_device *dev,
> > +				   unsigned long *supported,
> > +				   struct phylink_link_state *state)
> > +{
> > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
> > +
> > +	phylink_set(mask, Autoneg);
> > +	phylink_set_port_modes(mask);
> > +	phylink_set(mask, Pause);
> > +	phylink_set(mask, Asym_Pause);
> > +
> > +	phylink_set(mask, 10baseT_Half);
> > +	phylink_set(mask, 10baseT_Full);
> > +	phylink_set(mask, 100baseT_Half);
> > +	phylink_set(mask, 100baseT_Full);
> > +	phylink_set(mask, 1000baseT_Full);
> > +	phylink_set(mask, 1000baseX_Full);
> 
> AFAICS, the driver (before these patches) does not support 1000baseX
> as it always clears the MVPP2_GMAC_PORT_TYPE_MASK bit, so adding this
> mode should be part of the patch adding 1000baseX support.

Right, I'll remove 1000baseX_Full from this patch and only add it in the
1000BaseX support patch.

Thanks!
Antoine

-- 
Antoine T?nart, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
