From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Dec 2014 12:12:56 -0600
Subject: [PATCH 3/7] mfd: menelaus: add initial DT support
In-Reply-To: <20141228233445.GD582@fuloong-minipc.musicnaut.iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-4-git-send-email-aaro.koskinen@iki.fi>
 <20141227212553.GA21729@saruman>
 <20141228233445.GD582@fuloong-minipc.musicnaut.iki.fi>
Message-ID: <20141229181256.GN29379@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 29, 2014 at 01:34:45AM +0200, Aaro Koskinen wrote:
> > > Add initial DT support.
> > > 
> > > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/menelaus.txt | 30 +++++++++++++
> > >  drivers/mfd/menelaus.c                             | 52 ++++++++++++++++++++--
> > >  2 files changed, 78 insertions(+), 4 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/menelaus.txt b/Documentation/devicetree/bindings/mfd/menelaus.txt
> > > new file mode 100644
> > > index 0000000..5f69f23
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/menelaus.txt
> > > @@ -0,0 +1,30 @@
> > > +Menelaus (Texas Instruments TWL92330) Power Management chip
> > > +
> > > +Menelaus provides facilities to control the power resources.
> > > +
> > > +Required properties:
> > > +- compatible: must be "menelaus"
> > > +- reg: I2C address of the chip
> > > +
> > > +Optional properties:
> > > +- interrupts: the interrupt
> > > +- ti,autosleep: All regulators are put to sleep by default.
> > > +- ti,vcore-min-microvolt: Range floor for the HW controlled VCORE
> > > +- ti,vcore-max-microvolt: Range roof for the HW controlled VCORE
> > > +
> > > +The use of ti,autosleep is recommended at least on Nokia N800/N810.
> > > +
> > > +Example:
> > > +
> > > +&i2c1 {
> > > +	clock-frequency = <400000>;
> > > +
> > > +	pmic at 72 {
> > > +		compatible = "menelaus";
> > > +		reg = <0x72>;
> > > +		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> > > +		ti,autosleep;
> > > +		ti,vcore-min-microvolt = <1050000>;
> > > +		ti,vcore-max-microvolt = <1400000>;
> > 
> > looks like these should be first converted to actual regulators
> > otherwise we will have to maintain this binding forever which means that
> > any effort of adding regulator fwk support for menelaus will become a
> > lot more difficult because it'll have to cope with the legacy/bogus
> > binding.
> 
> I was thinking such conversion could be done with incremental patches...
> There's basically only one board (n8x0) that uses this and not likely
> to be any others. Is there a way to declare bindings unstable?

AFAICT, once they hit a major release, they're stable for life :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141229/34e7df09/attachment.sig>
