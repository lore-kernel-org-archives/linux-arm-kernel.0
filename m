From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 15 Jul 2017 10:12:02 +0200
Subject: [PATCH v2 3/6] ARM: dts: rockchip: add RGA device node for RK3288
In-Reply-To: <1500101920-24039-4-git-send-email-jacob-chen@iotwrt.com>
References: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
 <1500101920-24039-4-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1951692.C191PNKQbQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Am Samstag, 15. Juli 2017, 14:58:37 CEST schrieb Jacob Chen:
> This patch add the RGA dt config of rk3288 SoC.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>

from the Signed-off it looks like Yakir was te original author of the
patch. So please fix the authorship or drop the top Signed-off by.

Same for other patches like this.


Thanks
Heiko

> ---
>  arch/arm/boot/dts/rk3288.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 1efc2f2..83d025d 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -945,6 +945,19 @@
>  		status = "okay";
>  	};
>  
> +	rga: rga at ff920000 {
> +		compatible = "rockchip,rk3288-rga";
> +		reg = <0xff920000 0x180>;
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "rga";
> +		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA>;
> +		clock-names = "aclk", "hclk", "sclk";
> +		power-domains = <&power RK3288_PD_VIO>;
> +		resets = <&cru SRST_RGA_CORE>, <&cru SRST_RGA_AXI>, <&cru SRST_RGA_AHB>;
> +		reset-names = "core", "axi", "ahb";
> +		status = "disabled";
> +	};
> +
>  	vopb: vop at ff930000 {
>  		compatible = "rockchip,rk3288-vop";
>  		reg = <0xff930000 0x19c>;
> 
