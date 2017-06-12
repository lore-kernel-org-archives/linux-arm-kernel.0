From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Jun 2017 00:26:47 -0700
Subject: [PATCH 1/3] ARM: dts: omap4: add missing des_fck
In-Reply-To: <20170609231206.19798-2-sre@kernel.org>
References: <20170609231206.19798-1-sre@kernel.org>
 <20170609231206.19798-2-sre@kernel.org>
Message-ID: <20170612072647.GQ3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@kernel.org> [170609 16:16]:
> Add missing functional clock for DES3DES IP core. This is
> documented in the TRM as CM_L4SEC_DES3DES_CLKCTRL.

Tero care to ack? Also, see the other two hwmod patches
in this series for your clkctrl changes.

Regards,

Tony

> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  arch/arm/boot/dts/omap44xx-clocks.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap44xx-clocks.dtsi b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> index 9573b37fbaa7..e997265460d4 100644
> --- a/arch/arm/boot/dts/omap44xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap44xx-clocks.dtsi
> @@ -985,6 +985,14 @@
>  		reg = <0x15a8>;
>  	};
>  
> +	des_fck: des_fck at 15b0 {
> +		#clock-cells = <0>;
> +		compatible = "ti,gate-clock";
> +		clocks = <&l3_div_ck>;
> +		ti,bit-shift = <1>;
> +		reg = <0x15b0>;
> +	};
> +
>  	dss_sys_clk: dss_sys_clk at 1120 {
>  		#clock-cells = <0>;
>  		compatible = "ti,gate-clock";
> -- 
> 2.11.0
> 
