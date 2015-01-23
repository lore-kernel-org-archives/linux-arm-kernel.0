From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Jan 2015 09:43:54 +0000
Subject: [PATCH v2 4/9] ARM: STi: DT: STiH407: Add Device Tree node for
 the LPC
In-Reply-To: <54C208D9.6050006@st.com>
References: <1421927767-28889-1-git-send-email-lee.jones@linaro.org>
 <1421927767-28889-5-git-send-email-lee.jones@linaro.org>
 <54C208D9.6050006@st.com>
Message-ID: <20150123094354.GG9129@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Jan 2015, David Paris wrote:

> Hi Lee,
> 
>     Just a minor remark/question,
> 
>     David
> 
> On 01/22/2015 12:56 PM, Lee Jones wrote:
> >On current ST platforms the LPC controls a number of functions.  This
> >patch enables support for the LPC Watchdog and LPC RTC devices on LPC1
> >and LPC2 respectively.
> >
> >Signed-off-by: David Paris <david.paris@st.com>
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> >  arch/arm/boot/dts/stih407-family.dtsi | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> >index 3e31d32..04448a7 100644
> >--- a/arch/arm/boot/dts/stih407-family.dtsi
> >+++ b/arch/arm/boot/dts/stih407-family.dtsi
> >@@ -7,6 +7,7 @@
> >   * publishhed by the Free Software Foundation.
> >   */
> >  #include "stih407-pinctrl.dtsi"
> >+#include <dt-bindings/mfd/st-lpc.h>
> >  #include <dt-bindings/reset-controller/stih407-resets.h>
> >  / {
> >  	#address-cells = <1>;
> >@@ -274,5 +275,24 @@
> >  			status = "disabled";
> >  		};
> >+
> >+		/* Watchdog and Real-Time Clock */
> >+		lpc at 8787000 {
> >+			compatible = "st,stih407-lpc";
> >+			reg = <0x8787000 0x1000>;
> >+			interrupts = <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>;
> In case of Watchdog, "interrupt" property is not used. So I think we
> can remove it ?

Sure thing.

> >+			clocks = <&clk_s_d3_flexgen CLK_LPC_0>;
> >+			timeout-sec = <120>;
> >+			st,syscfg = <&syscfg_core>;
> >+			st,lpc-mode = <ST_LPC_MODE_WDT>;
> >+		};
> >+
> >+		lpc at 8788000 {
> >+			compatible = "st,stih407-lpc";
> >+			reg = <0x8788000 0x1000>;
> >+			interrupts = <GIC_SPI 130 IRQ_TYPE_EDGE_RISING>;
> >+			clocks = <&clk_s_d3_flexgen CLK_LPC_1>;
> >+			st,lpc-mode = <ST_LPC_MODE_RTC>;
> >+		};
> >  	};
> >  };
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
