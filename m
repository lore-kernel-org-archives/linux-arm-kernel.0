From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 25 Feb 2015 16:08:38 +0200
Subject: [PATCH 2/2] ARM: shmobile: r8a7794: add GPIO DT support
In-Reply-To: <54EDD685.1010802@cogentembedded.com>
References: <6954455.LyoCrfjM8R@wasted.cogentembedded.com>
 <2292882.LbM0mNWfOj@avalon> <54EDD685.1010802@cogentembedded.com>
Message-ID: <2278267.ajPYsg7oHK@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wednesday 25 February 2015 17:04:53 Sergei Shtylyov wrote:
> On 2/25/2015 1:11 PM, Laurent Pinchart wrote:
> >> Describe GPIO[0-6] controllers in the R8A7794 device tree.
> >> 
> >> Based on original patch by Hisashi Nakamura
> >> <hisashi.nakamura.ak@renesas.com>.
> >> 
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> 
> >> ---
> >> 
> >>   arch/arm/boot/dts/r8a7794.dtsi |   84 +++++++++++++++++++++++++++++++++
> >>   1 file changed, 84 insertions(+)
> >> 
> >> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
> >> ===================================================================
> >> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> >> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> >> @@ -50,6 +50,90 @@
> 
> [...]
> 
> >> +	gpio1: gpio at e6051000 {
> >> +		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
> >> +		reg = <0 0xe6051000 0 0x50>;
> >> +		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
> >> +		#gpio-cells = <2>;
> >> +		gpio-controller;
> >> +		gpio-ranges = <&pfc 0 32 32>;
> > 
> > This GPIO block has 26 GPIOs only.
> 
> [...]
> 
> >> +	gpio5: gpio at e6055000 {
> >> +		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
> >> +		reg = <0 0xe6055000 0 0x50>;
> >> +		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
> >> +		#gpio-cells = <2>;
> >> +		gpio-controller;
> >> +		gpio-ranges = <&pfc 0 160 32>;
> > 
> > This GPIO block has 28 GPIOs only.
> > 
> >> +		#interrupt-cells = <2>;
> >> +		interrupt-controller;
> >> +		clocks = <&mstp9_clks R8A7794_CLK_GPIO5>;
> >> +	};
> >> +
> >> +	gpio6: gpio at e6055400 {
> >> +		compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
> >> +		reg = <0 0xe6055400 0 0x50>;
> >> +		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
> >> +		#gpio-cells = <2>;
> >> +		gpio-controller;
> >> +		gpio-ranges = <&pfc 0 192 32>;
> > 
> > This GPIO block has 26 GPIOs only.
> 
> Yes, I know; I just wasn't sure what to do with the "gpio-ranges" prop of
> the following GPIO node. Should I keep the base GPIO # or update it as well?

I think the base number should be kept as-is, as the pfc driver indexes GPIOs 
using 32 * bank + offset. There are thus holes in the pfc pins array, but that 
shouldn't be a big deal (of course if you can find an easy way to optimize 
that, it would be welcome :-)).

-- 
Regards,

Laurent Pinchart
