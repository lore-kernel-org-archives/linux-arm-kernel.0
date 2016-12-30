From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 08:46:17 +0800
Subject: [PATCH] arm64: dts: ls1046a: add qdma device tree node
In-Reply-To: <1479180277-3823-1-git-send-email-hongbo.zhang@nxp.com>
References: <1479180277-3823-1-git-send-email-hongbo.zhang@nxp.com>
Message-ID: <20161230004613.GB6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 11:24:37AM +0800, hongbo.zhang at nxp.com wrote:
> From: Hongbo Zhang <hongbo.zhang@nxp.com>
> 
> The drivers/dma/fsl-qdma.c works for ls1046a too, this patch adds

I cannot find this driver on v4.10-rc1.  Please send me DTS changes only
after the driver and bindings part land on mainline.

Shawn

> device tree node for it.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
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
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
