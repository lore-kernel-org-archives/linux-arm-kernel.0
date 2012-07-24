From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Tue, 24 Jul 2012 09:11:09 +0000
Subject: [PATCH v2 2/2] arm/dts: Configure pinmuxs for user leds control
 on Bone
In-Reply-To: <20120724083007.GU6522@atomide.com>
References: <1342769508-24810-1-git-send-email-anilkumar@ti.com>
 <1342769508-24810-3-git-send-email-anilkumar@ti.com>
 <20120724083007.GU6522@atomide.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA026D0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Thanks for the review.

On Tue, Jul 24, 2012 at 14:00:08, Tony Lindgren wrote:
> * AnilKumar Ch <anilkumar@ti.com> [120720 00:36]:
> > Adds GPIO pinctrl nodes to am3358_pinmux master node to control
> > user leds (USR0, USR1, USR2 and USR3) present on BeagleBone.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/boot/dts/am335x-bone.dts |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > index a4d4415..452ce3f 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -28,3 +28,18 @@
> >  };
> >  
> >  /include/ "tps65217.dtsi"
> > +
> > +&am3358_pinmux {
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&userled_pins>;
> > +
> > +	userled_pins: pinmux_userled_pins {
> > +		pinctrl-single,pins = <
> > +			0x54 0x7	/* gpmc_a5.gpio1_21, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
> > +			0x58 0x17	/* gpmc_a6.gpio1_22, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
> > +			0x5C 0x7	/* gpmc_a7.gpio1_23, OMAP_PIN_OUTPUT | OMAP_MUX_MODE7 */
> > +			0x60 0x17	/* gpmc_a8.gpio1_24, OMAP_PIN_OUTPUT_PULLUP | OMAP_MUX_MODE7 */
> > +		>;
> > +	};
> > +};
> 
> Let's standardize on the following minimal commenting as those can be
> search and replaced the same way when we have preprocessing available:
> 
> 		pinctrl-single,pins = <
> 			0x54 0x7	/* gpmc_a5.gpio1_21  OUTPUT | MODE7 */
> 			0x58 0x17	/* gpmc_a6.gpio1_22, OUTPUT_PULLUP | MODE7 */
> 			0x5C 0x7	/* gpmc_a7.gpio1_23, OUTPUT | MODE7 */
> 			0x60 0x17	/* gpmc_a8.gpio1_24, OUTPUT_PULLUP | MODE7 */
> 		>;
> 

Point taken, I thought the same after v2 submission. I will send the updated
version with this fix.

Thanks
AnilKumar
