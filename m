From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 9 Jan 2018 16:17:35 +0100
Subject: [PATCH net-next v3 4/4] net: mvpp2: 2500baseX support
In-Reply-To: <20180109144447.GI17719@n2100.armlinux.org.uk>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
 <20180109085945.11916-5-antoine.tenart@free-electrons.com>
 <20180109144447.GI17719@n2100.armlinux.org.uk>
Message-ID: <20180109151735.GB23676@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jan 09, 2018 at 02:44:48PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 09, 2018 at 09:59:45AM +0100, Antoine Tenart wrote:
> > This patch adds the 2500Base-X PHY mode support in the Marvell PPv2
> > driver. 2500Base-X is quite close to 1000Base-X and SGMII modes and uses
> > nearly the same code path.
> 
> Sorry, also...

Comments always welcomed :)

> > @@ -4668,6 +4692,10 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
> >  		 */
> >  		val |= MVPP2_GMAC_CONFIG_GMII_SPEED |
> >  		       MVPP2_GMAC_CONFIG_FULL_DUPLEX;
> > +	else if (port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
> > +		val |= MVPP2_GMAC_CONFIG_GMII_SPEED |
> > +		       MVPP2_GMAC_CONFIG_MII_SPEED |
> > +		       MVPP2_GMAC_CONFIG_FULL_DUPLEX;
> 
> I think you'll find you don't need to set MII_SPEED here, since
> MII_SPEED selects between 10 and 100, GMII_SPEED always takes
> precidence selecting 1000, and 2500 is done by the comphy
> increasing the clocks by 2.5x.

I just had a look at the datasheet, and as you say it seems GMII_SPEED
takes over MII_SPEED. I'll see if there is a corner case here or if
selecting MII_SPEED doesn't make sense, and update accordingly.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
