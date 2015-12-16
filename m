From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 16 Dec 2015 21:30:30 +0100
Subject: [PATCH v2] arm64: dts: berlin4ct: switch to Cortex-A53 specific
 pmu nodes
In-Reply-To: <1450191475-1371-1-git-send-email-jszhang@marvell.com>
References: <1450191475-1371-1-git-send-email-jszhang@marvell.com>
Message-ID: <5671C9E6.9080701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.12.2015 15:57, Jisheng Zhang wrote:
> Commit ac82d1277215 ("arm64: perf: add Cortex-A53 support") adds the
> cortex A53 PMU support, thus instead of using the generic armv8-pmuv3
> compatibility use the more specific Cortex A53 compatibility.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Since v1:
>  - keep "arm,armv8-pmuv3" as a fallback in the compatible list. Thank
>    Arnd and Mark.

Applied to berlin64/dt with an updated commit message that
reflects v2 changes.

Sebastian

>  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> index 099ad93..f926256 100644
> --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> @@ -115,7 +115,7 @@
>  	};
>  
>  	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
>  		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> 
