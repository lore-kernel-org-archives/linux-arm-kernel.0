From: rachna@ti.com (Patil, Rachna)
Date: Tue, 22 Jan 2013 09:31:02 +0000
Subject: [PATCH v3 4/8] MFD: ti_am335x_tscadc: add device tree binding
 information
In-Reply-To: <50FB1DFE.6090805@metafoo.de>
References: <cover.1358502134.git.rachna@ti.com>
 <daf18b4779ac3c6b69b1e7e2d1a4abd18b13fee5.1358502134.git.rachna@ti.com>
 <50FB1DFE.6090805@metafoo.de>
Message-ID: <4CE347531D4CA947960AF71FF095B9323E9AFB02@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 20, 2013 at 03:58:14, Lars-Peter Clausen wrote:
> Hi,
> 
> On 01/18/2013 11:48 AM, Patil, Rachna wrote:
> > From: "Patil, Rachna" <rachna@ti.com>
> > 
> > Signed-off-by: Patil, Rachna <rachna@ti.com>
> > ---
> >  .../devicetree/bindings/mfd/ti_am335x_tscadc.txt   |   35 ++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 
> > Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
> > 
> > diff --git 
> > a/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt 
> > b/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
> > new file mode 100644
> > index 0000000..c13c492
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt
> > @@ -0,0 +1,35 @@
> > +Texas Instruments - TSC / ADC multi-functional device
> > +
> > +ti_tscadc is a multi-function device with touchscreen and ADC on chip.
> > +This document describes the binding for mfd device.
> > +
> > +Required properties:
> > +- compatible: "ti,ti-tscadc"
> > +- reg: Specifies the address of MFD block
> > +- interrupts: IRQ line connected to the main SoC
> > +- interrupt-parent: The parent interrupt controller
> 
> The subnodes and their properties also need documentation.

Ok. I Will add this.

> 
> > +
> > +Optional properties:
> > +- ti,hwmods: Hardware information related to TSC/ADC MFD device
> > +
> > +Example:
> > +
> > +	tscadc: tscadc at 44e0d000 {
> > +		compatible = "ti,ti-tscadc";
> > +		reg = <0x44e0d000 0x1000>;
> > +
> > +		interrupt-parent = <&intc>;
> > +		interrupts = <16>;
> > +		ti,hwmods = "adc_tsc";
> > +
> > +		tsc {
> > +			wires = <4>;
> > +			x-plate-resistance = <200>;
> > +			steps-to-configure = <5>;
> > +			wire-config = <0x00 0x11 0x22 0x33>;
> 
> Non-standard properties should have a vendor prefix.

Ok. I will fix this in the next version of the patch set.

Regards,
Rachna
