From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Feb 2014 10:37:06 +0000
Subject: [PATCH v6 2/3] serial: fsl_lpuart: add DMA support
In-Reply-To: <1392614888-10261-3-git-send-email-yao.yuan@freescale.com>
References: <1392614888-10261-1-git-send-email-yao.yuan@freescale.com>
 <1392614888-10261-3-git-send-email-yao.yuan@freescale.com>
Message-ID: <20140217103706.GA18920@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 05:28:07AM +0000, Yuan Yao wrote:
> Add dma support for lpuart. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts node.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  19 +-
>  drivers/tty/serial/fsl_lpuart.c                    | 430 ++++++++++++++++++++-
>  2 files changed, 433 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..6e1cbbf 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -5,10 +5,19 @@ Reqiuired properties:
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> 
> +Optional properties:
> +- dmas: A list of two dma specifiers, one for each entry in dma-names.
> +- dma-names: should contain "tx" and "rx".
> +
> +Note: Optional properties for DMA support. Write them both or both not.
> +
>  Example:
> 
>  uart0: serial at 40027000 {
> -              compatible = "fsl,vf610-lpuart";
> -              reg = <0x40027000 0x1000>;
> -              interrupts = <0 61 0x00>;
> -       };
> +               compatible = "fsl,vf610-lpuart";
> +               reg = <0x40027000 0x1000>;
> +               interrupts = <0 61 0x00>;
> +               dmas = <&edma0 0 2>,
> +                       <&edma0 0 3>;
> +               dma-names = "rx","tx";
> +       };

For the binding:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
