From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 07 Jan 2015 15:39:18 +0100
Subject: [PATCH v2 2/3] ARM: dts: berlin: add PPI cpu mask to twd timer
 interrupts
In-Reply-To: <1419584281-4811-3-git-send-email-jszhang@marvell.com>
References: <1419584281-4811-1-git-send-email-jszhang@marvell.com>
 <1419584281-4811-3-git-send-email-jszhang@marvell.com>
Message-ID: <54AD4516.7050608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.12.2014 09:58, Jisheng Zhang wrote:
> According to the gic binding document, "bits[15:8] PPI interrupt cpu
> mask.  Each bit corresponds to each of the 8 possible cpus attached to
> the GIC.  A bit set to '1' indicated the interrupt is wired to that
> CPU." This patch wants to add the PPI cpu mask for completeness.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to berlin/dt.

Thanks!

> ---
>   arch/arm/boot/dts/berlin2.dtsi   | 2 +-
>   arch/arm/boot/dts/berlin2cd.dtsi | 2 +-
>   arch/arm/boot/dts/berlin2q.dtsi  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> index 015a06c..63d00a6 100644
> --- a/arch/arm/boot/dts/berlin2.dtsi
> +++ b/arch/arm/boot/dts/berlin2.dtsi
> @@ -104,7 +104,7 @@
>   		local-timer at ad0600 {
>   			compatible = "arm,cortex-a9-twd-timer";
>   			reg = <0xad0600 0x20>;
> -			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>   			clocks = <&chip CLKID_TWD>;
>   		};
>
> diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
> index a318bc3..81b670a 100644
> --- a/arch/arm/boot/dts/berlin2cd.dtsi
> +++ b/arch/arm/boot/dts/berlin2cd.dtsi
> @@ -76,7 +76,7 @@
>   		local-timer at ad0600 {
>   			compatible = "arm,cortex-a9-twd-timer";
>   			reg = <0xad0600 0x20>;
> -			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
>   			clocks = <&chip CLKID_TWD>;
>   		};
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 933dcbb..41a683f 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -112,7 +112,7 @@
>   			compatible = "arm,cortex-a9-twd-timer";
>   			reg = <0xad0600 0x20>;
>   			clocks = <&chip CLKID_TWD>;
> -			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>   		};
>
>   		gic: interrupt-controller at ad1000 {
>
