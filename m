From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Fri, 3 Jun 2016 20:20:52 +0530
Subject: [PATCH v2 3/7] binding: mdio-mux: Add DT binding doc for Broadcom
 MDIO bus mutiplexer
In-Reply-To: <20160603014323.GA12365@rob-hp-laptop>
References: <1464701801-17243-1-git-send-email-pramod.kumar@broadcom.com>
 <1464701801-17243-4-git-send-email-pramod.kumar@broadcom.com>
 <20160603014323.GA12365@rob-hp-laptop>
Message-ID: <a18d8d629426ccbca1a9da19241a6e5d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: 03 June 2016 07:13
> To: Pramod Kumar
> Cc: Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala; Catalin Marinas;
Will
> Deacon; Kishon Vijay Abraham I; David S. Miller;
devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; bcm-kernel-feedback-
> list at broadcom.com; linux-kernel at vger.kernel.org; netdev at vger.kernel.org
> Subject: Re: [PATCH v2 3/7] binding: mdio-mux: Add DT binding doc for
> Broadcom MDIO bus mutiplexer
>
> On Tue, May 31, 2016 at 07:06:37PM +0530, Pramod Kumar wrote:
> > Add DT binding doc for Broadcom MDIO bus mutiplexer driver.
> >
> > Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> > ---
> >  .../bindings/net/brcm,mdio-mux-iproc.txt           | 60
> ++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> > b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> > new file mode 100644
> > index 0000000..f270b41
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
> > @@ -0,0 +1,60 @@
> > +Properties for an MDIO bus mutiplexer found in Broadcom iProc based
SoCs.
> > +
> > +This MDIO bus multiplexer defines buses that could be internal as
> > +well as external to SoCs and could accept MDIO transaction compatible
> > +to C-22 or
> > +C-45 Clause. When Child bus is selected, one need to select these two
>
> s/Child/child/

Sure. Will ensure this.

> s/need/needs/

Sure. Will ensure this.

> > +properties as well to generate desired MDIO trascation on appropriate
bus.
> > +
> > +Required properties in addition to the generic multiplexer
properties:
> > +
> > +MDIO multiplexer node:
> > +- complatible: brcm,mdio-mux-iproc.
>
> typo
>
Fixed.
> > +
> > +Every non-ethernet PHY requires a compatible so that it could be
> > +probed based on this compatible string.
> > +
> > +Additional information regarding generic multiplexer properties could
> > +be found
>
> s/could/can/
>

Replaced.

> > +at- Documentation/devicetree/bindings/net/mdio-mux.txt
> > +
> > +
> > +for example:
> > +		mdio_mux_iproc: mdio_mux_iproc at 6602023c {
>
> No '_' in node names.
>
> mdio-mux at ...

Yes. Will take care of this.
>
> > +			compatible = "brcm,mdio-mux-iproc";
> > +			reg = <0x6602023c 0x14>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			mdio-integrated-mux;
> > +
> > +			mdio at 0 {
> > +				reg = <0x0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pci_phy0: pci-phy at 0 {
> > +					compatible = "brcm,ns2-pcie-phy";
> > +					reg = <0x0>;
> > +					#phy-cells = <0>;
> > +				};
> > +			};
> > +
> > +			mdio at 7 {
> > +				reg = <0x7>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				pci_phy1: pci-phy at 0 {
> > +					compatible = "brcm,ns2-pcie-phy";
> > +					reg = <0x0>;
> > +					#phy-cells = <0>;
> > +				};
> > +			};
> > +			mdio at 10 {
> > +				reg = <0x10>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				gphy0: eth-phy at 10 {
> > +					reg = <0x10>;
> > +				};
> > +			};
> > +		};
> > --
> > 1.9.1
> >

Regards,
Pramod
