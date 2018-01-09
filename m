From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 9 Jan 2018 16:54:11 +0100
Subject: [PATCH net-next v3 4/4] net: mvpp2: 2500baseX support
In-Reply-To: <20180109151735.GB23676@kwain>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
 <20180109085945.11916-5-antoine.tenart@free-electrons.com>
 <20180109144447.GI17719@n2100.armlinux.org.uk>
 <20180109151735.GB23676@kwain>
Message-ID: <20180109155411.GD23676@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 09, 2018 at 04:17:35PM +0100, Antoine Tenart wrote:
> On Tue, Jan 09, 2018 at 02:44:48PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Jan 09, 2018 at 09:59:45AM +0100, Antoine Tenart wrote:
> > >  		val |= MVPP2_GMAC_CONFIG_GMII_SPEED |
> > >  		       MVPP2_GMAC_CONFIG_FULL_DUPLEX;
> > > +	else if (port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
> > > +		val |= MVPP2_GMAC_CONFIG_GMII_SPEED |
> > > +		       MVPP2_GMAC_CONFIG_MII_SPEED |
> > > +		       MVPP2_GMAC_CONFIG_FULL_DUPLEX;
> > 
> > I think you'll find you don't need to set MII_SPEED here, since
> > MII_SPEED selects between 10 and 100, GMII_SPEED always takes
> > precidence selecting 1000, and 2500 is done by the comphy
> > increasing the clocks by 2.5x.
> 
> I just had a look at the datasheet, and as you say it seems GMII_SPEED
> takes over MII_SPEED. I'll see if there is a corner case here or if
> selecting MII_SPEED doesn't make sense, and update accordingly.

I just checked, this can be removed for this mode. I'll update the
patch.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
