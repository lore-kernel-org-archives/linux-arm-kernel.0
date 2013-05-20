From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 20 May 2013 05:30:21 +0000
Subject: [PATCH 2/2] ARM: dts: AM33XX: Set pinmux for clkout2 pad used
 for clock output
In-Reply-To: <alpine.DEB.2.00.1305200250250.2656@utopia.booyaka.com>
References: <1367919574-21353-1-git-send-email-hvaibhav@ti.com>
 <1367919574-21353-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1305200250250.2656@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC8E716@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Monday, May 20, 2013 8:21 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; tony at atomide.com; Cousson, Benoit;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] ARM: dts: AM33XX: Set pinmux for clkout2 pad
> used for clock output
> 
> Hi
> 
> something that you should fix:
> 
> On Tue, 7 May 2013, Vaibhav Hiremath wrote:
> 
> > xdma_event_intr1.clkout2 pad can be used to source clock
> > from either 32K OSC or any of the PLL (except MPU) outputs.
> > On the existing AM335x based boards (EVM, EVM-SK and Bone),
> > this pad is used to feed the clock to audio codes.
> >
> > So, this patch configures the pinmux to get clkout2 on the pad.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/boot/dts/am335x-bone.dts  |    8 +++++++-
> >  arch/arm/boot/dts/am335x-evm.dts   |    8 +++++++-
> >  arch/arm/boot/dts/am335x-evmsk.dts |    8 +++++++-
> >  3 files changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts
> b/arch/arm/boot/dts/am335x-bone.dts
> > index bfba6fc..f4630a3 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -26,7 +26,7 @@
> >
> >  	am33xx_pinmux: pinmux at 44e10800 {
> >  		pinctrl-names = "default";
> > -		pinctrl-0 = <>;
> > +		pinctrl-0 = <&clkout2_pin>;
> >
> >  		user_leds_s0: user_leds_s0 {
> >  			pinctrl-single,pins = <
> > @@ -50,6 +50,12 @@
> >  				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN |
> MODE0 */
> >  			>;
> >  		};
> > +
> > +		clkout2_pin: pinumx_clkout2_pin {
> 
> "pinmux" is misspelled here and in several other parts of this file.
> 

Very good catch. Once misspelled and it gets copy-pasted everywhere :)

Will send next version shortly.

Thanks,
Vaibhav
