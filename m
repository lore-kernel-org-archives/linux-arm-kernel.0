From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Jun 2016 19:15:59 +0200
Subject: [PATCH 1/4] dt-bindings: Add A10 I2S controller binding
 documentation
In-Reply-To: <20160606130818.GA6952@rob-hp-laptop>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-2-maxime.ripard@free-electrons.com>
 <20160606130818.GA6952@rob-hp-laptop>
Message-ID: <20160609171559.GF5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, Jun 06, 2016 at 08:08:18AM -0500, Rob Herring wrote:
> On Wed, Jun 01, 2016 at 07:54:27PM +0200, Maxime Ripard wrote:
> > Introduce the device tree binding for the I2S controller found in the
> > Allwinner A10 and later SoCs.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../devicetree/bindings/sound/sun4i-i2s.txt        | 33 ++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> > new file mode 100644
> > index 000000000000..365ca4eede5f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> > @@ -0,0 +1,33 @@
> > +* Allwinner A10 I2S controller
> > +
> > +The I2S bus (Inter-IC sound bus) is a serial link for digital
> > +audio data transfer between devices in the system.
> > +
> > +Required properties:
> > +
> > +- compatible: should be one of the followings
> > +   - "allwinner,sun4i-a10-i2s"
> > +- reg: physical base address of the controller and length of memory mapped
> > +  region.
> > +- interrupts: should contain the I2S interrupt.
> > +- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
> > +	Documentation/devicetree/bindings/dma/dma.txt
> > +- dma-names: should include "tx" and "rx".
> > +- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
> > +- clock-names: should contain followings:
> > +   - "apb" : clock for the I2S bus interface
> > +   - "mod" : module clock for the I2S controller
> > +
> > +Example:
> > +
> > +i2s0: i2s at 01c22400 {
> > +	#sound-dai-cells = <0>;
> 
> This is missing from the property list.

Indeed, I'll add it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/5cf9624a/attachment.sig>
