From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 27 Feb 2014 16:36:43 +0000
Subject: [PATCH v0 12/15] ARM: STi: DT: STiH416: 416 DT Entry for
 clockgen B/C/D/E/F
In-Reply-To: <1393514668-17440-13-git-send-email-gabriel.fernandez@st.com>
References: <1393514668-17440-1-git-send-email-gabriel.fernandez@st.com>
 <1393514668-17440-13-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20140227163643.GC24910@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Patch adds DT entries for clockgen B/C/D/E/F
> 
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>

You need to add your Signed-off-by too.

> ---
>  arch/arm/boot/dts/stih416-clock.dtsi | 170 +++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih416-clock.dtsi b/arch/arm/boot/dts/stih416-clock.dtsi
> index f63b0a1..6b2e387 100644
> --- a/arch/arm/boot/dts/stih416-clock.dtsi
> +++ b/arch/arm/boot/dts/stih416-clock.dtsi
> @@ -503,5 +503,175 @@
>  						/* Remaining outputs unused */
>  			};
>  		};

This doesn't look right. Have you indented one tab too far?

> +                /*
> +                 * Frequency synthesizers on the SASG2.
> +                 *
> +                 */

Too many *'s

<snip>

> +                CLK_S_VCC_HD: CLK_S_VCC_HD {
> +                        #clock-cells = <0>;
> +                        compatible = "st,stih416-clkgenc-vcc-hd", "st,clkgen-mux";
> +                        reg = <0xfe8308b8 4>; /* SYSCFG2558 */

0x4

> +                /*
> +                 * Add a dummy clock for the HDMI PHY for the VCC input mux
> +                 */
> +                CLK_S_TMDS_FROMPHY: CLK_S_TMDS_FROMPHY {
> +                        #clock-cells = <0>;
> +                        compatible = "fixed-clock";
> +                        clock-frequency = <0>;

What happens when the clock frequency is 0?
> +                };
> +
> +                CLOCKGEN_C_VCC: CLOCKGEN_C_VCC {
> +                        #clock-cells = <1>;
> +                        compatible = "st,stih416-clkgenc", "st,clkgen-vcc";
> +                        reg = <0xfe8308ac 12>; /* SYSCFG2555,2556,2557 */

0x12, or 0x0C, whichever is appropriate.

> +                        clocks = <&CLK_S_VCC_HD>, <&CLOCKGEN_C 1>,
> +                                 <&CLK_S_TMDS_FROMPHY>, <&CLOCKGEN_C 2>;

One per line would probably be better, save confusing them for pairs.

<snip>

> +		/*
> +		 * Frequency synthesizers on the MPE42
> +		 */

Alignment.

<snip>

> +                CLOCKGEN_F: CLOCKGEN_F {
> +                        #clock-cells = <1>;
> +                        compatible = "st,stih416-quadfs660-F", "st,quadfs";
> +                        reg = <0xfd320878 0xF0>;
> +
> +                        clocks = <&CLK_SYSIN>;
> +                        clock-output-names = "CLK_M_MAIN_VIDFS",
> +                                             "CLK_M_HVA_FS",
> +                                             "CLK_M_FVDP_VCPU",
> +					     "CLK_M_FVDP_PROC_FS";

Tabbing. Ensure you're using tabs (and not spaces) everywhere.

<snip>

> +                        reg = <0xfd320910 4>; /* SYSCFG8580 */

0x...

Do this for all of the below too.


<snip>

> +                        clock-output-names  =
> +                                "CLK_M_PIX_MAIN_PIPE",  "CLK_M_PIX_AUX_PIPE",
> +                                "CLK_M_PIX_MAIN_CRU",   "CLK_M_PIX_AUX_CRU",
> +                                "CLK_M_XFER_BE_COMPO",  "CLK_M_XFER_PIP_COMPO",
> +                                "CLK_M_XFER_AUX_COMPO", "CLK_M_VSENS",
> +                                "CLK_M_PIX_HDMIRX_0",   "CLK_M_PIX_HDMIRX_1";
> +                };
>  	};
>  };

Something strange going on with these.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
