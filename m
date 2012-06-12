From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Jun 2012 14:04:33 +0200
Subject: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
In-Reply-To: <20120610170620.GW14756@titan.lakedaemon.net>
References: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
 <20120610170620.GW14756@titan.lakedaemon.net>
Message-ID: <20120612120433.GA17893@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +		spi at 10600 {
> > +			compatible = "marvell,orion-spi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			cell-index = <0>;
> > +			reg = <0x10600 0x28>;
> > +			status = "disabled";
> > +		};
> > +

> > index fa51586..0942139 100644
> > --- a/arch/arm/mach-kirkwood/board-dt.c
> > +++ b/arch/arm/mach-kirkwood/board-dt.c
> > @@ -26,6 +26,11 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
> >  	{ }
> >  };
> >  
> > +struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
> > +	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> 
> Isn't this ---------------------------------^^^^^^^^^^ defined somewhere?

Hi Jason

Yes, there is a #define for this. However, in this case, i think the
number actually tells you more. The dtsi file has the number, not some
symbolic representation. Also, some platforms, e.g. Dove, have more
than one spi controller. Having the number there makes it easier to
see the mapping between the node in DT and the name used in the
platform device. If we use the #define it means making an indirection
via kirkwood.h for a human to see the mapping.

However, i can change it...

	 Andrew
