From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri, 31 Aug 2018 16:23:10 +0200
Subject: [PATCH net-next v3 02/10] net: mvpp2: phylink support
In-Reply-To: <20180831141851.GA19733@lunn.ch>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain> <20180831141851.GA19733@lunn.ch>
Message-ID: <20180831142310.GC32574@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Fri, Aug 31, 2018 at 04:18:51PM +0200, Andrew Lunn wrote:
> > @@ -4691,6 +4685,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
> >  	if (fwnode_property_read_bool(port_fwnode, "marvell,loopback"))
> >  		port->flags |= MVPP2_F_LOOPBACK;
> >  
> > +	if (fwnode_property_present(port_fwnode, "fixed-link"))
> > +		port->flags |= MVPP2_F_FIXED_LINK;
> > +
> 
> There is no need to go look in device tree. When phylink calls
> mac_config() it passes mode == MLO_AN_FIXED, when it is using a fixed
> link.

Sure. This was a proposal to have a workaround when phylink does not
call link_up(), so that we know which mode to pass to the function.

In the meantime Russell explained an assumption about the carrier link
state made by phylink, and a proposal to avoid doing this kind of hack
in the driver. I'll test his solution which will probably means we can
drop this piece of code.

Thanks!
Antoine

-- 
Antoine T?nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
