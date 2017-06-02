From: j-keerthy@ti.com (Keerthy)
Date: Fri, 2 Jun 2017 14:53:19 +0530
Subject: [PATCH] ARM: dts: Remove min and max voltage values for dcdc3
In-Reply-To: <1496395308-29471-1-git-send-email-j-keerthy@ti.com>
References: <1496395308-29471-1-git-send-email-j-keerthy@ti.com>
Message-ID: <99d7bac7-164c-bc71-edff-6d3590a92298@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 02 June 2017 02:51 PM, Keerthy wrote:
> dcdc3 supplies to DDR on AM43x series. When we set both
> min and max values to the same value. The regulator framework
> sets that particular voltage. This is bad as we are changing
> the ddr voltage when executing from ddr. Hence remove the min and
> max values. The ddr supply voltage shall be set from bootloader
> when not executing from ddr and not while executing from kernel.

Apologies for the $subject. I will send v2 with $Subject corrected.

> 
> The previous discussion can be found here:
> 
> http://www.spinics.net/lists/devicetree/msg56399.html
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts  | 2 --
>  arch/arm/boot/dts/am437x-sk-evm.dts  | 2 --
>  arch/arm/boot/dts/am43x-epos-evm.dts | 2 --
>  3 files changed, 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 397e98b..29a538e 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -549,8 +549,6 @@
>  
>  		dcdc3: regulator-dcdc3 {
>  			regulator-name = "vdcdc3";
> -			regulator-min-microvolt = <1500000>;
> -			regulator-max-microvolt = <1500000>;
>  			regulator-boot-on;
>  			regulator-always-on;
>  			regulator-state-mem {
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> index a62e158..2c6bf06 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -451,8 +451,6 @@
>  
>  		dcdc3: regulator-dcdc3 {
>  			regulator-name = "vdds_ddr";
> -			regulator-min-microvolt = <1500000>;
> -			regulator-max-microvolt = <1500000>;
>  			regulator-boot-on;
>  			regulator-always-on;
>  			regulator-state-mem {
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index f6648ab..54f40f3 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -442,8 +442,6 @@
>  
>  		dcdc3: regulator-dcdc3 {
>  			regulator-name = "vdcdc3";
> -			regulator-min-microvolt = <1500000>;
> -			regulator-max-microvolt = <1500000>;
>  			regulator-boot-on;
>  			regulator-always-on;
>  		};
> 
