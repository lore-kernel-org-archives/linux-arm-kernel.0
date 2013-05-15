From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 May 2013 18:57:26 +0200
Subject: [PATCHv2 3/3] arm: dts: add bandgap entry for OMAP4460 devices
In-Reply-To: <5193B9AA.7020507@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-4-git-send-email-eduardo.valentin@ti.com>
 <5193A875.1020000@ti.com> <5193B9AA.7020507@ti.com>
Message-ID: <20130515165726.GK22508@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:36 Wed 15 May     , Eduardo Valentin wrote:
> On 15-05-2013 11:23, Benoit Cousson wrote:
> > Hi Eduardo,
> > 
> > On 05/15/2013 04:58 PM, Eduardo Valentin wrote:
> >> Include bandgap devices for OMAP4460 devices.
> >>
> >> Cc: "Beno?t Cousson" <b-cousson@ti.com>
> >> Cc: Tony Lindgren <tony@atomide.com>
> >> Cc: Russell King <linux@arm.linux.org.uk>
> >> Cc: linux-omap at vger.kernel.org
> >> Cc: devicetree-discuss at lists.ozlabs.org
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: linux-kernel at vger.kernel.org
> >> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> >> ---
> >>  arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
> >> index 2cf227c..e5bfbfe 100644
> >> --- a/arch/arm/boot/dts/omap4460.dtsi
> >> +++ b/arch/arm/boot/dts/omap4460.dtsi
> >> @@ -29,4 +29,13 @@
> >>  			     <0 55 0x4>;
> >>  		ti,hwmods = "debugss";
> >>  	};
> >> +
> >> +	bandgap {
> >> +		reg = <0x4a002260 0x4
> >> +			0x4a00232C 0x4
> >> +			0x4a002378 0x18>;
> >> +		compatible = "ti,omap4460-bandgap";
> >> +		interrupts = <0 126 4>; /* talert */
> >> +		ti,tshut-gpio = <86>;
> 
> 
> 
> > 
> > Why do you need a custom attribute for GPIO? Cannot you use the standard
> > one?
> 
> I believe it was by your suggestion :-), during the first attempts to
> send this driver. But could not find the thread link :-( sorry.
> 
> 
> I guess the reasoning to mark it as a ti specific is because it will be
> used as IRQ line to treat thermal shutdown (in SW).
so use interrup-parent
> 
> > 
> > Where is the gpio controller phandle?
> > 
> > Usually it looks like this:
> > 
> > 	gpios = <&gpio1 8 0>;
> > 
> > 
> > Regards,
> > Benoit
> > 
> > 
> > 
> 
> 



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
