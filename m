From: balajitk@ti.com (Balaji T K)
Date: Wed, 26 Jun 2013 22:03:54 +0530
Subject: [PATCH 3/5] ARM: dts: am33xx: Add interrupts and memory resources
 for MMC
In-Reply-To: <1372209888-6649-1-git-send-email-joelagnel@ti.com>
References: <1372209888-6649-1-git-send-email-joelagnel@ti.com>
Message-ID: <51CB17F2.5060504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On Wednesday 26 June 2013 06:54 AM, Joel A Fernandes wrote:
> From: Joel A Fernandes <agnel.joel@gmail.com>
>
> HWMOD irq entries for MMC were removed. We provide the same from DT for MMC.
>
> This fixes issue where memory resource could not be found during probe.
> Also, added the reg-offset property to account for the offset from start.
>
> Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
> ---
>   arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 119f8a9..e0a5741 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -237,6 +237,10 @@
>   			dmas = <&edma 24
>   				&edma 25>;
>   			dma-names = "tx", "rx";
> +			interrupts = <64>;
> +			interrupt-parent = <&intc>;
> +			reg = <0x48060000 0x1000>;
> +			reg-offset = <0x100>;
>   			status = "disabled";
>   		};
>
> @@ -247,6 +251,10 @@
>   			dmas = <&edma 2
>   				&edma 3>;
>   			dma-names = "tx", "rx";
> +			interrupts = <24>;

s/24/28

> +			interrupt-parent = <&intc>;
> +			reg = <0x481d8000 0x1000>;
> +			reg-offset = <0x100>;
>   			status = "disabled";
>   		};
>
> @@ -254,6 +262,10 @@
>   			compatible = "ti,omap3-hsmmc";

compatible should be ti,omap4-hsmmc since omap4 hsmmc IP is re-used in am33xx
and reg-offset property is not needed.
combine this patch with 2/5 ARM: dts: add AM33XX MMC support and please add
your signed-off to that patch.

>   			ti,hwmods = "mmc3";
>   			ti,needs-special-reset;
> +			interrupts = <25>;

s/25/29

> +			interrupt-parent = <&intc>;
> +			reg = <0x47810000 0x1000>;
> +			reg-offset = <0x100>;
>   			status = "disabled";
>   		};
>
>
