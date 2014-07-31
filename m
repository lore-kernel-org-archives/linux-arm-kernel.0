From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Jul 2014 18:26:56 +0400
Subject: [PATCH 2/6] ARM: DTS: da850: Add node for edma0
In-Reply-To: <1406801934-23334-3-git-send-email-peter.ujfalusi@ti.com>
References: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>
 <1406801934-23334-3-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <53DA5230.1050200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 02:18 PM, Peter Ujfalusi wrote:

> Add DT node for edma0.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   arch/arm/boot/dts/da850.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index b695548dbb4e..41ce4e8bf227 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -150,6 +150,12 @@
>   			};
>
>   		};
> +		edma0: edma at 01c00000 {
> +			compatible = "ti,edma3";
> +			reg =	<0x0 0x10000>;

    Why the mismatch between the unit-address part of the node name and the 
"reg" property?

> +			interrupts = <11 13 12>;
> +			#dma-cells = <1>;
> +		};

WBR, Sergei
