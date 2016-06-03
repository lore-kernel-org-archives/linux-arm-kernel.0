From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Fri, 3 Jun 2016 19:11:44 +0530
Subject: [PATCH v2 1/7] mdio:mux: Enhanced MDIO mux framework for
 integrated multiplexers
In-Reply-To: <20160601130207.GE31982@lunn.ch>
References: <1464701801-17243-1-git-send-email-pramod.kumar@broadcom.com>
 <1464701801-17243-2-git-send-email-pramod.kumar@broadcom.com>
 <20160601130207.GE31982@lunn.ch>
Message-ID: <722986e44cf0e0fbb8073605c8d8dcda@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: 01 June 2016 18:32
> To: Pramod Kumar
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala;
Catalin
> Marinas; Will Deacon; Kishon Vijay Abraham I; David S. Miller;
> devicetree at vger.kernel.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; bcm-kernel-feedback-list at broadcom.com;
linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 1/7] mdio:mux: Enhanced MDIO mux framework for
> integrated multiplexers
>
> > diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c index
> > 8453f08..cf40e7a 100644
> > --- a/drivers/of/of_mdio.c
> > +++ b/drivers/of/of_mdio.c
> > @@ -225,6 +225,9 @@ int of_mdiobus_register(struct mii_bus *mdio,
struct
> device_node *np)
> >  	if (rc)
> >  		return rc;
> >
> > +	if (of_property_read_bool(np, "mdio-integrated-mux"))
> > +		return 0;
> > +
>
> Hi
>
> Rather than doing this, did you try setting bus->phy_mask = 0 and
calling
> mdiobus_register(), rather than of_mdiobus_regsiter() for the parent
bus?
>

After setting bus->phy_mask = ~0 and using mdiobus_regsiter() I could get
rid of newly added
Property. It works for me as I find same has been done inside of
of_mdiobus_regsiter().

Thanks for pointing out this.

> 	Andrew
