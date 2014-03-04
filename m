From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 04 Mar 2014 15:13:03 +0100
Subject: [PATCH 7/7] PCI: designware: split samsung and fsl bindings
In-Reply-To: <201402282103.01897.arnd@arndb.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <1393608523-17509-8-git-send-email-l.stach@pengutronix.de>
 <201402282103.01897.arnd@arndb.de>
Message-ID: <1393942383.9405.8.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 28.02.2014, 21:03 +0100 schrieb Arnd Bergmann:
> On Friday 28 February 2014, Lucas Stach wrote:
> > +Required properties:
> > +- compatible: "fsl,imx6q-pcie"
> > +- reg: base addresse and length of the pcie controller
> > +- interrupts: First entry must contain interrupt handle for controller
> > +  INTA output.
> 
> I think this should be documented as "optional" and only for
> backwards compatibility with old kernels.
> 
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +       See ../clocks/clock-bindings.txt for details.
> > +- clock-names: Must include the following entries: 
> > +       - "pcie_ref_125m"
> > +       - "sata_ref_100m"
> > +       - "lvds_gate"
> > +       - "pcie_axi"
> 
> I don't understand why you have completely different clocks here
> from the exynos documentation. The clock names should really be
> the same. Also, why do you have a "sata_ref_100m" clock?
> Is this just driving a device that happens to be on-board
> for a specific machine? Same for the "lvds_gate".
> 

Right, we should be able to reuse the clock names. Though I'm not really
sure how the Samsung clocks maps to those used on i.MX, as the names are
a bit generic. Maybe someone from Samsung could shed a bit of light on
this.

On i.MX6 the clock names (which I have to agree are pretty bad) map as
follows:
pcie_axi: host controller main register/bus access clock
pcie_ref_125m: pcie phy reference clock

sata_ref_100m: pcie bus 100MHz reference clock
lvds_gate: bad abstraction. Decides if the reference clock is sourced
internal (i.e. the 100MHz ref clock above) or from an SoC external
source. We should really find a better way of representing this in the
clock tree.

Regards,
Lucas

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
