From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Dec 2017 08:34:37 -0800
Subject: [PATCH v3 3/3] arm64: dts: meson-axg: add clock DT info for
 Meson AXG SoC
In-Reply-To: <8353c264-3253-0268-91fc-8d42fbe82611@amlogic.com>
References: <20171128125330.363-1-yixun.lan@amlogic.com>
 <20171128125330.363-4-yixun.lan@amlogic.com>
 <20171129193536.GB19419@codeaurora.org>
 <8353c264-3253-0268-91fc-8d42fbe82611@amlogic.com>
Message-ID: <20171201163437.GE19419@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30, Yixun Lan wrote:
> Hi Stephen
> 
> On 11/30/17 03:35, Stephen Boyd wrote:
> > On 11/28, Yixun Lan wrote:
> >> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> index b932a784b02a..36a2e98338a8 100644
> >> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> >> @@ -7,6 +7,7 @@
> >>  #include <dt-bindings/gpio/gpio.h>
> >>  #include <dt-bindings/interrupt-controller/irq.h>
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +#include <dt-bindings/clock/axg-clkc.h>
> >>  
> >>  / {
> >>  	compatible = "amlogic,meson-axg";
> >> @@ -148,6 +149,20 @@
> >>  			#address-cells = <0>;
> >>  		};
> >>  
> >> +		hiubus: hiubus at ff63c000 {
> > 
> > Maybe just call the node "bus at ff63c000"?
> > 
> isn't this just a name? what's the benefits to change?
> personally, I tend to keep it this way, because it's better map to the
> data sheet
> 
> we also has 'aobus', 'cbus' scattered there..

Per the ePAPR node names are supposed to be generic, like disk,
cpu, display-controller, gpu, etc. I've never heard of a hiubus,
so probably it's some vendor specific thing? We have the phandle
anyway so it's not like we're losing much information here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
