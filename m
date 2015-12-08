From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 08 Dec 2015 11:33:39 +0100
Subject: [PATCH v9 3/8] ARM: dt: Binding documentation for imx25
 touchscreen controller
In-Reply-To: <20151207204546.GA30936@rob-hp-laptop>
References: <1449431542-1892-1-git-send-email-mpa@pengutronix.de>
 <1449431542-1892-4-git-send-email-mpa@pengutronix.de>
 <20151207204546.GA30936@rob-hp-laptop>
Message-ID: <6094071.cpaNNKXzrc@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 07 December 2015 14:45:46 Rob Herring wrote:
> On Sun, Dec 06, 2015 at 08:52:16PM +0100, Markus Pargmann wrote:
> > This is the touchscreen conversion queue binding documentation. It uses
> > the shared imx25 ADC.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> > 
> > Notes:
> >     Changes in v9:
> >      - Updated binding descriptions
> >     
> >     Changes in v5:
> >      - Fix signed/unsigned comparison
> >      - Fix unused variable settling_time by putting it in the correct argument list
> >      - Use continous conversion queue with the repeat feature and a proper
> >        repeat-wait. Previously the touchscreen caused massive number of interrupts.
> > 
> >  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 35 ++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> > new file mode 100644
> > index 000000000000..d45e50872114
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
> > @@ -0,0 +1,35 @@
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
> 
> This and ...
> 
> > + - fsl,pen-threshold: Pen-down threshold for the touchscreen. This is a value
> > +   between 1 and 4096. It is the ratio between the internal reference voltage
> > +   and the measured voltage after the plate was precharged. Resistence between
> > +   plates and therefore the voltage decreases with pressure so that a smaller
> > +   value is equivalent to a higher pressure.
> > + - fsl,settling-time: Settling time in nanoseconds. The settling time is before
> > +   the actual touch detection to wait for an even charge distribution in the
> > +   plate.
> 
> ... this still need units (-ns) appended to the property name.

Thanks. I wasn't aware that the property names itself should include the units.
Will fix that.

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
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/c613f5d7/attachment-0001.sig>
