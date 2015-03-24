From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 24 Mar 2015 17:10:58 +0100
Subject: [PATCH v7 3/8] ARM: dt: Binding documentation for imx25
 touchscreen controller
In-Reply-To: <54FB3740.6010908@kernel.org>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-4-git-send-email-mpa@pengutronix.de>
 <54FB3740.6010908@kernel.org>
Message-ID: <20150324161058.GJ28604@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 07, 2015 at 05:37:04PM +0000, Jonathan Cameron wrote:
> On 03/03/15 07:58, Markus Pargmann wrote:
> > This is the touchscreen conversion queue binding documentation. It uses
> > the shared imx25 ADC.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Looks fine, one more general binding approach comment though.
> A lot of the vendor specific elements in here are awfully generic.
> Does it not make sense to have them as standard attributes for
> touch screen drivers?
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
> > index 000000000000..4214a99d197a
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
> > + - fsl,pen-debounce: Pen debounce time.
> > + - fsl,pen-threshold: Pen-down threshold for the touchscreen.
> > + - fsl,settling-time: Settling time in nanoseconds.
> Obviously it's up to Dmitry etc, but are these not standard enough attributes to
> not be vendor specific?  I'd expect say touch-pen-debouce and touch-pen-threshold
> etc to be standard binding elements for touch screens.

Seems like a good idea. I just discovered that there is a 'touchscreen-fuzz-pressure'
which seems to be the same as fsl,pen-threshold. So this should be
replaced in my patches. The other properties do not exist.

Dmitry, what do you think about some standard properties for the
remaining?

Best Regards,

Markus

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/2d48dd22/attachment.sig>
