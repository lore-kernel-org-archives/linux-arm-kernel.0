From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Feb 2016 16:25:58 -0800
Subject: [PATCH] ARM: DTS: am57xx-beagle-x15: Select SYS_CLK2 for audio
 clocks
In-Reply-To: <1455018417-2608-1-git-send-email-peter.ujfalusi@ti.com>
References: <1455018417-2608-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160211002558.GP19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160209 03:48]:
> The tlv320aic3104 codec's master clock is coming from the SoC's CLKOUT2.
> Select the SYS_CLK2 (via divider) as parent clock for CLKOUT2 and select
> the same clock (SYS_CLK2) for McASP3 AHCLKX clock as well.
> SYS_CLK2 is sourced from an external oscillator running 22.5792MHz and it
> is coming in to the SoC via the X1_OSC1.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applying into omap-for-v4.5/fixes thanks.

Tony

> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index c37a5193f199..592e65c3a4e0 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -173,6 +173,8 @@
>  
>  		sound0_master: simple-audio-card,codec {
>  			sound-dai = <&tlv320aic3104>;
> +			assigned-clocks = <&clkoutmux2_clk_mux>;
> +			assigned-clock-parents = <&sys_clk2_dclk_div>;
>  			clocks = <&clkout2_clk>;
>  		};
>  	};
> @@ -795,6 +797,8 @@
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&mcasp3_pins_default>;
>  	pinctrl-1 = <&mcasp3_pins_sleep>;
> +	assigned-clocks = <&mcasp3_ahclkx_mux>;
> +	assigned-clock-parents = <&sys_clkin2>;
>  	status = "okay";
>  
>  	op-mode = <0>;	/* MCASP_IIS_MODE */
> -- 
> 2.7.1
> 
