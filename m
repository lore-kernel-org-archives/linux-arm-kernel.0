From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Apr 2016 21:51:25 +0530
Subject: [PATCH v2 3/4] fsl-imx-sdma.txt: Document 'fsl, sdma-event-remap'
 property
In-Reply-To: <1459554737-19684-3-git-send-email-festevam@gmail.com>
References: <1459554737-19684-1-git-send-email-festevam@gmail.com>
 <1459554737-19684-3-git-send-email-festevam@gmail.com>
Message-ID: <20160413162125.GV2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 08:52:16PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Document the 'fsl,sdma-event-remap' property and provide an example of
> its usage.

just 2/3 patch so I have no idea of the series. Whats going on?

> 
> Cc: Vinod Koul <vinod.koul@intel.com> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since v1:
> - Newly introduced in this series
> 
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index dc8d3aa..175f0e4 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -58,6 +58,15 @@ The third cell specifies the transfer priority as below.
>  	1	Medium
>  	2	Low
>  
> +Optional properties:
> +
> +- gpr : The phandle to the General Purpose Register (GPR) node.
> +- fsl,sdma-event-remap : Register bits of sdma event remap, the format is
> +  <reg shift val>.
> +    reg is the GPR register offset.
> +    shift is the bit position inside the GPR register.
> +    val is the value of the bit (0 or 1).
> +
>  Examples:
>  
>  sdma at 83fb0000 {
> @@ -83,3 +92,21 @@ ssi2: ssi at 70014000 {
>  	dma-names = "rx", "tx";
>  	fsl,fifo-depth = <15>;
>  };
> +
> +Using the fsl,sdma-event-remap property:
> +
> +If we want to use SDMA on the SAI1 port on a MX6SX:
> +
> +&sdma {
> +	gpr = <&gpr>;
> +	/* SDMA events remap for SAI1_RX and SAI1_TX */
> +	fsl,sdma-event-remap = <0 15 1>, <0 16 1>;
> +};
> +
> +The fsl,sdma-event-remap property in this case has two values:
> +- <0 15 1> means that the offset is 0, so GPR0 is the register of the
> +SDMA remap. Bit 15 of GPR0 selects between UART4_RX and SAI1_RX.
> +Setting bit 15 to 1 selects SAI1_RX.
> +- <0 16 1> means that the offset is 0, so GPR0 is the register of the
> +SDMA remap. Bit 16 of GPR0 selects between UART4_TX and SAI1_TX.
> +Setting bit 16 to 1 selects SAI1_TX.
> -- 
> 1.9.1
> 

-- 
~Vinod
