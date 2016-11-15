From: hongbo.zhang@nxp.com (H.B. Zhang)
Date: Tue, 15 Nov 2016 05:23:46 +0000
Subject: [PATCH] arm64: dts: ls1046a: add qdma device tree node
In-Reply-To: <1479180277-3823-1-git-send-email-hongbo.zhang@nxp.com>
References: <1479180277-3823-1-git-send-email-hongbo.zhang@nxp.com>
Message-ID: <DB3PR04MB08126D835BAF17EB9C4FE73284BF0@DB3PR04MB0812.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is against the latest linux-next, and the binding file is being upstreamed by the qdma driver author Yuan Yao, so it isn't include in this patch.

> -----Original Message-----
> From: hongbo.zhang at nxp.com [mailto:hongbo.zhang at nxp.com]
> Sent: Tuesday, November 15, 2016 11:25 AM
> To: linux-arm-kernel at lists.infradead.org; Yao Yuan <yao.yuan@nxp.com>;
> shawnguo at kernel.org
> Cc: H.B. Zhang <hongbo.zhang@nxp.com>
> Subject: [PATCH] arm64: dts: ls1046a: add qdma device tree node
> 
> From: Hongbo Zhang <hongbo.zhang@nxp.com>
> 
> The drivers/dma/fsl-qdma.c works for ls1046a too, this patch adds
> device tree node for it.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 38806ca..6edf7cf 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -511,5 +511,19 @@
>  			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clockgen 4 1>;
>  		};
> +
> +		qdma: qdma at 8380000 {
> +			compatible = "fsl,ls1046a-qdma", "fsl,ls1021a-qdma";
> +			reg = <0x0 0x838f000 0x0 0x11000 /* Controller regs */
> +			       0x0 0x83a0000 0x0 0x40000>; /* Block regs */
> +			interrupts = <0 152 0x4>,
> +				     <0 39 0x4>;
> +			interrupt-names = "qdma-error", "qdma-queue";
> +			channels = <8>;
> +			queues = <2>;
> +			status-sizes = <64>;
> +			queue-sizes = <64 64>;
> +			big-endian;
> +		};
>  	};
>  };
> --
> 2.1.4
> 
