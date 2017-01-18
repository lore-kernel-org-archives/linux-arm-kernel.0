From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 18 Jan 2017 12:25:00 +0100
Subject: [PATCH 2/2] ARM: DTS: Fix register map for virt-capable GIC
In-Reply-To: <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
References: <1484736811-24002-1-git-send-email-marc.zyngier@arm.com>
 <1484736811-24002-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <2229087.5bOlf9DNaK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 18. Januar 2017, 10:53:31 CET schrieb Marc Zyngier:
> Since everybody copied my own mistake from the DT binding example,
> let's address all the offenders in one swift go.
> 
> Most of them got the CPU interface size wrong (4kB, while it should
> be 8kB), except for both keystone platforms which got the control
> interface wrong (4kB instead of 8kB).
> 
> In the couple of cases were I knew for sure what implementation
> was used, I've added the "arm,gic-400" compatible string. I'm 99%
> sure that this is what everyong is using, but short of having the
> TRM for all the other SoCs, I've let them alone.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

for the Rockchip parts
Acked-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/arch/arm/boot/dts/rk1108.dtsi b/arch/arm/boot/dts/rk1108.dtsi
> index d770023..d6194bf 100644
> --- a/arch/arm/boot/dts/rk1108.dtsi
> +++ b/arch/arm/boot/dts/rk1108.dtsi
> @@ -215,7 +215,7 @@
>  		#address-cells = <0>;
> 
>  		reg = <0x32011000 0x1000>,
> -		      <0x32012000 0x1000>,
> +		      <0x32012000 0x2000>,
>  		      <0x32014000 0x2000>,
>  		      <0x32016000 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) | 
IRQ_TYPE_LEVEL_HIGH)>;
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index 4ed49a2..ff9b90b 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -189,7 +189,7 @@
>  		#address-cells = <0>;
> 
>  		reg = <0x10139000 0x1000>,
> -		      <0x1013a000 0x1000>,
> +		      <0x1013a000 0x2000>,
>  		      <0x1013c000 0x2000>,
>  		      <0x1013e000 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | 
IRQ_TYPE_LEVEL_HIGH)>;
> diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
> index 9d3aee5..9dff822 100644
> --- a/arch/arm/boot/dts/rk322x.dtsi
> +++ b/arch/arm/boot/dts/rk322x.dtsi
> @@ -443,7 +443,7 @@
>  		#address-cells = <0>;
> 
>  		reg = <0x32011000 0x1000>,
> -		      <0x32012000 0x1000>,
> +		      <0x32012000 0x2000>,
>  		      <0x32014000 0x2000>,
>  		      <0x32016000 0x2000>;
>  		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | 
IRQ_TYPE_LEVEL_HIGH)>;
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 4fad133..af46cba 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1110,7 +1110,7 @@
>  		#address-cells = <0>;
> 
>  		reg = <0xffc01000 0x1000>,
> -		      <0xffc02000 0x1000>,
> +		      <0xffc02000 0x2000>,
>  		      <0xffc04000 0x2000>,
>  		      <0xffc06000 0x2000>;
>  		interrupts = <GIC_PPI 9 0xf04>;
