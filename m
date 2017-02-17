From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 17 Feb 2017 13:18:39 +0100
Subject: [PATCH 04/21] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner dwmac-sun8i
In-Reply-To: <20170216184818.hwexzuqacbemsxo7@lukather>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
 <20170216124859.14346-5-clabbe.montjoie@gmail.com>
 <20170216184818.hwexzuqacbemsxo7@lukather>
Message-ID: <20170217121839.GA24993@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 07:48:18PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Feb 16, 2017 at 01:48:42PM +0100, Corentin Labbe wrote:
> > This patch adds documentation for Device-Tree bindings for the
> > Allwinner dwmac-sun8i driver.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  .../devicetree/bindings/net/dwmac-sun8i.txt        | 86 ++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> > new file mode 100644
> > index 0000000..ac806c6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
> > @@ -0,0 +1,86 @@
> > +* Allwinner sun8i GMAC ethernet controller
> > +
> > +This device is a platform glue layer for stmmac.
> > +Please see stmmac.txt for the other unchanged properties.
> > +
> > +Required properties:
> > +- compatible: should be one of the following string:
> > +		"allwinner,sun8i-a83t-emac"
> > +		"allwinner,sun8i-h3-emac"
> > +		"allwinner,sun50i-a64-emac"
> > +- reg: address and length of the register for the device.
> > +- interrupts: interrupt for the device
> > +- interrupt-names: should be "macirq"
> > +- clocks: A phandle to the reference clock for this device
> > +- clock-names: should be "stmmaceth"
> > +- resets: A phandle to the reset control for this device
> > +- reset-names: should be "stmmaceth"
> > +- phy-mode: See ethernet.txt
> > +- phy-handle: See ethernet.txt
> > +- #address-cells: shall be 1
> > +- #size-cells: shall be 0
> > +- syscon: A phandle to the syscon of the SoC with one of the following
> > + compatible string:
> > +  - allwinner,sun8i-h3-system-controller
> > +  - allwinner,sun8i-a64-system-controller
> > +  - allwinner,sun8i-a83t-system-controller
> > +
> > +Optional properties:
> > +- allwinner,tx-delay: TX clock delay chain value. Range value is 0-0x07. Default is 0)
> > +- allwinner,rx-delay: RX clock delay chain value. Range value is 0-0x1F. Default is 0)
> > +Both delay properties does not have units, there are arbitrary value.
> > +The TX/RX clock delay chain settings are board specific and could be found
> > +in vendor FEX files.
> > +
> > +Optional properties for "allwinner,sun8i-h3-emac":
> > +- allwinner,leds-active-low: EPHY LEDs are active low
> > +
> > +Required child node of emac:
> > +- mdio bus node: should be named mdio
> > +
> > +Required properties of the mdio node:
> > +- #address-cells: shall be 1
> > +- #size-cells: shall be 0
> > +
> > +The device node referenced by "phy" or "phy-handle" should be a child node
> > +of the mdio node. See phy.txt for the generic PHY bindings.
> > +
> > +Required properties of the phy node with "allwinner,sun8i-h3-emac":
> > +- clocks: an extra phandle to the reference clock for the EPHY
> > +- resets: an extra phandle to the reset control for the EPHY
> > +
> > +Required properties for the system controller:
> > +- reg: address and length of the register for the device.
> > +- compatible: should be "syscon" and one of the following string:
> > +		"allwinner,sun8i-h3-system-controller"
> > +		"allwinner,sun8i-a64-system-controller"
> > +		"allwinner,sun8i-a83t-system-controller"
> 
> This should be in a separate binding document.
> 
> What does it describe / represent?
> 
> Thanks,
> Maxime
> 

I agree, I will split it in two one for syscon, one for emac

Thanks
Corentin Labbe
