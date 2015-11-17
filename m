From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 17 Nov 2015 09:54:03 +0100
Subject: [PATCH v8 3/8] ARM: dt: Binding documentation for imx25
 touchscreen controller
In-Reply-To: <20151116141609.GA6167@rob-hp-laptop>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-4-git-send-email-mpa@pengutronix.de>
 <20151116141609.GA6167@rob-hp-laptop>
Message-ID: <2927401.FasWCEIy4W@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 16 November 2015 08:16:09 Rob Herring wrote:
> On Mon, Nov 16, 2015 at 01:01:04PM +0100, Markus Pargmann wrote:
> > This is the touchscreen conversion queue binding documentation. It uses
> > the shared imx25 ADC.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> > 
> > Notes:
> >     Changes in v5:
> >      - Fix signed/unsigned comparison
> >      - Fix unused variable settling_time by putting it in the correct argument list
> >      - Use continous conversion queue with the repeat feature and a proper
> >        repeat-wait. Previously the touchscreen caused massive number of interrupts.
> > 
> >  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> > new file mode 100644
> > index 000000000000..89ab47a3acc1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> > @@ -0,0 +1,29 @@
> > +Freescale mx25 TS conversion queue module
> > +
> > +mx25 touchscreen conversion queue module which controls the ADC unit of the
> > +mx25 for attached touchscreens.
> > +
> > +Required properties:
> > + - compatible: Should be "fsl,imx25-tcq".
> > + - reg: Memory range of the device.
> > + - interrupts: Should be the interrupt number associated with this module within
> > +   the tscadc unit (<0>).
> > + - interrupt-parent: Should be a phandle to the tscadc unit.
> > + - fsl,wires: Should be '<4>' or '<5>'
> > +
> > +Optional properties:
> > + - fsl,pen-debounce: Pen debounce time in nanoseconds.
> > + - fsl,pen-threshold: Pen-down threshold for the touchscreen.
> > + - fsl,settling-time: Settling time in nanoseconds.
> 
> Don't we have standard properties for these? If not, these should have 
> units.

I just found properties like 'debounce_timeout' without a vendor prefix but
they don't seem to be standard properties:
	Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt

For fsl,pen-threshold there is no real unit. It is the ratio between the
internal voltage reference and the measured voltage after one of the
touchscreen plates was precharged. However there are limits, I will add a
better description.

> 
> I don't understand the difference between debounce and settling times. 
> Please make that clear in the doc.

The settling time is the time waited after charging the touchscreen plates. The
pen-debounce time is a delay after a pen down has been detected.

Best Regards,

Markus

> 
> Rob
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/097d61ed/attachment.sig>
