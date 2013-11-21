From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 21 Nov 2013 09:29:49 +0100
Subject: [PATCH v2] ARM: shmobile: Fix r8a7790 GPIO resources in DTS
In-Reply-To: <20131121051929.16956.72693.sendpatchset@w520>
References: <20131121051929.16956.72693.sendpatchset@w520>
Message-ID: <2488980.PvOPQv8Pxa@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Thursday 21 November 2013 14:19:29 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The r8a7790 GPIO resources are currently incorrect. Fix that
> by making them match the English r8a7790 v0.6 data sheet.
> 
> Tested with GPIO LED using Lager DT reference.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Just before I go and hide for such an obvious mistake,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

:-)

> ---
> 
>  Change since V1:
>  - Update commit message to include data sheet version
> 
>  arch/arm/boot/dts/r8a7790.dtsi |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> --- 0017/arch/arm/boot/dts/r8a7790.dtsi
> +++ work/arch/arm/boot/dts/r8a7790.dtsi	2013-11-20 17:37:37.000000000 +0900
> @@ -90,9 +90,9 @@
>  		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  	};
> 
> -	gpio0: gpio at ffc40000 {
> +	gpio0: gpio at e6050000 {
>  		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
> -		reg = <0 0xffc40000 0 0x2c>;
> +		reg = <0 0xe6050000 0 0x50>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
>  		#gpio-cells = <2>;
> @@ -102,9 +102,9 @@
>  		interrupt-controller;
>  	};
> 
> -	gpio1: gpio at ffc41000 {
> +	gpio1: gpio at e6051000 {
>  		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
> -		reg = <0 0xffc41000 0 0x2c>;
> +		reg = <0 0xe6051000 0 0x50>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
>  		#gpio-cells = <2>;
> @@ -114,9 +114,9 @@
>  		interrupt-controller;
>  	};
> 
> -	gpio2: gpio at ffc42000 {
> +	gpio2: gpio at e6052000 {
>  		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
> -		reg = <0 0xffc42000 0 0x2c>;
> +		reg = <0 0xe6052000 0 0x50>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
>  		#gpio-cells = <2>;
> @@ -126,9 +126,9 @@
>  		interrupt-controller;
>  	};
> 
> -	gpio3: gpio at ffc43000 {
> +	gpio3: gpio at e6053000 {
>  		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
> -		reg = <0 0xffc43000 0 0x2c>;
> +		reg = <0 0xe6053000 0 0x50>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
>  		#gpio-cells = <2>;
> @@ -138,9 +138,9 @@
>  		interrupt-controller;
>  	};
> 
> -	gpio4: gpio at ffc44000 {
> +	gpio4: gpio at e6054000 {
>  		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
> -		reg = <0 0xffc44000 0 0x2c>;
> +		reg = <0 0xe6054000 0 0x50>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
>  		#gpio-cells = <2>;
> @@ -150,9 +150,9 @@
>  		interrupt-controller;
>  	};
> 
> -	gpio5: gpio at ffc45000 {
> +	gpio5: gpio at e6055000 {
>  		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
> -		reg = <0 0xffc45000 0 0x2c>;
> +		reg = <0 0xe6055000 0 0x50>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
>  		#gpio-cells = <2>;
-- 
Regards,

Laurent Pinchart
