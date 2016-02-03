From: dirk.behme@gmail.com (Dirk Behme)
Date: Wed, 3 Feb 2016 18:20:52 +0100
Subject: [PATCH v2] arm64: dts: r8a7795: pmu: switch to Cortex specific
 device nodes
In-Reply-To: <1452953636-4995-1-git-send-email-dirk.behme@gmail.com>
References: <1452953636-4995-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <56B236F4.4090409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.01.2016 15:13, Dirk Behme wrote:
> Instead of using the generic armv8-pmuv3 compatibility use the more
> specific Cortex A57 compatibility.
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> ---
> Changes in v2: Drop the not yet merged Cortex A53 part.
>
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 266c5de..a82bce8 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -247,8 +247,8 @@
>   			power-domains = <&cpg>;
>   		};
>
> -		pmu {
> -			compatible = "arm,armv8-pmuv3";
> +		pmu_a57 {
> +			compatible = "arm,cortex-a57-pmu";
>   			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
>


Any further comments to this? If not, could this be applied?

Best regards

Dirk
