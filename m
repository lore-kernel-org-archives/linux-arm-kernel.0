From: carlo@caione.org (Carlo Caione)
Date: Sat, 15 Mar 2014 16:48:43 +0100
Subject: [PATCH v2 7/8] ARM: sun7i: dt: Add AXP209 support to various
 boards
In-Reply-To: <53247584.8060701@redhat.com>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-8-git-send-email-carlo@caione.org>
 <53247584.8060701@redhat.com>
Message-ID: <20140315154843.GA23186@localhost.fastwebnet.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 04:45:08PM +0100, Hans de Goede wrote:
> Hi,
> 
> Thanks for your continued work on this.
> 
> On 03/15/2014 04:43 PM, Carlo Caione wrote:
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Carlo Caione <carlo@caione.org>
> > ---
> >  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 12 ++++++++++++
> >  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 13 +++++++++++++
> >  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 12 ++++++++++++
> >  3 files changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> > index 5c51cb8..9ad7da5 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> > @@ -53,6 +53,18 @@
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&i2c0_pins_a>;
> >  			status = "okay";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			axp: axp20x at 34 {
> > +				reg = <0x34>;
> > +				interrupt-parent = <&nmi_intc>;
> > +				interrupts = <0 8>;
> > +
> > +				axp,system-power-controller;
> 
> Shouldn't this be dropped now (all 3 of them) ?

Damn! Thank you for spotting it.
Fix coming.

Thanks,

-- 
Carlo Caione
