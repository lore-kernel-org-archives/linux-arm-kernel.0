From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Tue, 31 May 2016 17:34:13 +0530
Subject: [PATCH 3/7] binding: mdio-mux: Add DT binding doc for Broadcom
 MDIO bus mutiplexer
In-Reply-To: <20160530152426.GM6027@lunn.ch>
References: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
 <1464592251-2688-4-git-send-email-pramod.kumar@broadcom.com>
 <20160530152426.GM6027@lunn.ch>
Message-ID: <e002ac1b95d8ee4725f7315427f65fbf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: 30 May 2016 20:54
> To: Pramod Kumar
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala;
Catalin
> Marinas; Will Deacon; Kishon Vijay Abraham I; David S. Miller;
> devicetree at vger.kernel.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; bcm-kernel-feedback-list at broadcom.com;
linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/7] binding: mdio-mux: Add DT binding doc for
Broadcom
> MDIO bus mutiplexer
>
> On Mon, May 30, 2016 at 12:40:47PM +0530, Pramod Kumar wrote:
> > Add DT binding doc for Broadcom MDIO bus mutiplexer driver.
> >
> > Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> > ---
> >  .../bindings/net/brcm,mdio-mux-iproc.txt           | 64
> ++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> > b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> > new file mode 100644
> > index 0000000..dd74ee0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> > @@ -0,0 +1,64 @@
> > +Properties for an MDIO bus mutiplexer found in Broadcom iProc based
SoCs.
> > +
> > +This MDIO bus multiplexer defines buses that could be internal as
> > +well as external to SoCs and could accept MDIO transaction compatible
> > +to C-22 or
> > +C-45 Clause. When Child bus is selected, one need to select these two
> > +properties as well to generate desired MDIO trascation on appropriate
bus.
> > +
> > +Required properties in addition to the generic multiplexer
properties:
> > +
> > +MDIO multiplexer node:
> > +- complatible: brcm,mdio-mux-iproc.
> > +
> > +Child bus node:
> > +-brcm,is-c45: Boolean property indicating PHYs attached to this bus
supports
> > +	      C-45 mdio transaction.
>
> This is-c45 seems to be at the wrong level. As far as i know, you can
mix C22 and
> C45 devices on a bus. It is a property of the individual MDIO device if
it uses C45
> or not.
>
> I would expect your MDIO device PHY drivers to logically OR
> MII_ADDR_C45 into the address when doing an MDIO read/write using C45.
>

Yes. I agree. We will logical OR MII_ADDR_C45 into the address from PHY
drivers. Is there any standard property exist for non-ethernet-phy DRIVERS
to decide the whether PHY node support C45 or C22?

Or shall I define a new one like "mdio-device-c45" or something similar
name in PHY DT NODE.


> 	     Andrew

Regards,
Pramod
