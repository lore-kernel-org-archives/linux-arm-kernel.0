From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 7 Jan 2014 21:05:58 +0800
Subject: [PATCHv9 2/4] ARM: dts: Add Freescale FTM PWM node for VF610.
In-Reply-To: <1389082438-2199-1-git-send-email-Li.Xiubo@freescale.com>
References: <1389082438-2199-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20140107130557.GI12346@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xiubo,

On Tue, Jan 07, 2014 at 04:13:57PM +0800, Xiubo Li wrote:
> This adds devicetree node for VF610, and there are 8 channels
> supported.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Has the FTM PWM device tree bindings been accepted/merged?  Please only
send me DTS changes after that.  Also when you send me the DTS changes,
please base on imx/dt or for-next branch of my git tree below.

  git://git.linaro.org/people/shawnguo/linux-2.6.git

Shawn

> ---
> 
> No changes since v7.
> 
> 
>  arch/arm/boot/dts/vf610.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index d31ce1b..6cce861 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -152,6 +152,19 @@
>  				clock-names = "pit";
>  			};
>  
> +			pwm0: pwm at 40038000 {
> +				compatible = "fsl,vf610-ftm-pwm";
> +				#pwm-cells = <3>;
> +				reg = <0x40038000 0x1000>;
> +				clock-names = "ftm_sys", "ftm_ext",
> +					      "ftm_fix", "ftm_cnt_clk_en";
> +				clocks = <&clks VF610_CLK_FTM0>,
> +					<&clks VF610_CLK_FTM0_EXT_SEL>,
> +					<&clks VF610_CLK_FTM0_FIX_SEL>,
> +					<&clks VF610_CLK_FTM0_EXT_FIX_EN>;
> +				status = "disabled";
> +			};
> +
>  			wdog at 4003e000 {
>  				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
>  				reg = <0x4003e000 0x1000>;
> -- 
> 1.8.4
> 
> 
