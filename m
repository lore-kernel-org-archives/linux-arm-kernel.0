From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 5 Aug 2015 21:46:03 +0800
Subject: [PATCH v5 2/2] ARM: dts: add property for maximum ADC clock
 frequencies
In-Reply-To: <f598169164aaacc28292d8ccc6afb32d@agner.ch>
References: <1432730872-14325-1-git-send-email-stefan@agner.ch>
 <1432730872-14325-3-git-send-email-stefan@agner.ch>
 <557477BE.5050108@kernel.org>
 <f598169164aaacc28292d8ccc6afb32d@agner.ch>
Message-ID: <20150805134603.GN12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 02:22:30PM +0200, Stefan Agner wrote:
> Hi Shawn,
> 
> I guess this will go through your tree? Haven't seen it appear on imx/dt
> so far...

Sorry.  I missed it.  Please use my kernel.org mailbox, which I'm using
for kernel maintenance now.

Applied, thanks.

Shawn

> 
> --
> Stefan
> 
> On 2015-06-07 18:56, Jonathan Cameron wrote:
> > On 27/05/15 13:47, Stefan Agner wrote:
> >> The ADC clock frequency is limited depending on modes used. Add
> >> device tree property which allow to set the mode used and the
> >> maximum frequency ratings for the instance. These allows to
> >> set the ADC clock to a frequency which is within specification
> >> according to the actual mode used.
> >>
> >> Acked-by: Fugang Duan <B38611@freescale.com>
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> > I'm happy to take this via IIO if people want me to, otherwise give
> > it's connection to the previous patch that I just applied,
> > 
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > 
> >> ---
> >>  arch/arm/boot/dts/vfxxx.dtsi | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> >> index a29c7ce..c6609bd 100644
> >> --- a/arch/arm/boot/dts/vfxxx.dtsi
> >> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> >> @@ -189,6 +189,8 @@
> >>  				clocks = <&clks VF610_CLK_ADC0>;
> >>  				clock-names = "adc";
> >>  				status = "disabled";
> >> +				fsl,adck-max-frequency = <30000000>, <40000000>,
> >> +							<20000000>;
> >>  			};
> >>
> >>  			wdoga5: wdog at 4003e000 {
> >> @@ -387,6 +389,8 @@
> >>  				clocks = <&clks VF610_CLK_ADC1>;
> >>  				clock-names = "adc";
> >>  				status = "disabled";
> >> +				fsl,adck-max-frequency = <30000000>, <40000000>,
> >> +							<20000000>;
> >>  			};
> >>
> >>  			esdhc1: esdhc at 400b2000 {
> >>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
