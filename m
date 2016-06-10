From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Fri, 10 Jun 2016 09:54:11 +0530
Subject: [PATCH v4 4/7] dt: mdio-mux: Add mdio multiplexer driver node
In-Reply-To: <5755C2FE.1090303@gmail.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-5-git-send-email-pramod.kumar@broadcom.com>
 <5755C2FE.1090303@gmail.com>
Message-ID: <0581378b82179ea816fb2f8644d3fc93@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> -----Original Message-----
> From: Florian Fainelli [mailto:f.fainelli at gmail.com]
> Sent: 07 June 2016 00:08
> To: Pramod Kumar; Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell;
> Kumar Gala; Catalin Marinas; Will Deacon; Kishon Vijay Abraham I; David S.
> Miller
> Cc: devicetree at vger.kernel.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; bcm-kernel-feedback-list at broadcom.com; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v4 4/7] dt: mdio-mux: Add mdio multiplexer driver node
>
> On 06/06/2016 05:41 AM, Pramod Kumar wrote:
> > Add integrated MDIO multiplexer driver node which contains two mux
> > PCIe bus and one ethernet bus along with phys lying on these bus.
> >
> > Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> > ---
> > +		mdio_mux_iproc: mdio-mux at 6602023c {
> > +			compatible = "brcm,mdio-mux-iproc";
> > +			reg = <0x6602023c 0x14>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
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
>
> Are these two PHYs always available in the NS2 SoC, or does that depend on
> interfaces exposed at the board level? Should not they be flagged with a
> disabled status property by default and enabled in their respective board
> files?
> --

It depends on the interfaces exposed at board level. We will disable it in
dtsi and enable it dts file. I'll address this through next patch set.

> Florian

Regards,
Pramod
