From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jan 2014 11:31:14 +0000
Subject: [PATCH v4 2/3] serial: fsl_lpuart: add DMA support
In-Reply-To: <1390363773-24108-3-git-send-email-yao.yuan@freescale.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <1390363773-24108-3-git-send-email-yao.yuan@freescale.com>
Message-ID: <20140124113114.GE814@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 04:09:32AM +0000, Yuan Yao wrote:
> Add dma support for lpuart. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts node.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  19 +-
>  drivers/tty/serial/fsl_lpuart.c                    | 430 ++++++++++++++++++++-
>  2 files changed, 433 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..6e1cbbf 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -5,10 +5,21 @@ Required properties:
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> 
> +Optional properties:
> +- dmas: Generic dma devicetree binding as described
> +       in Documentation/devicetree/bindings/dma/dma.txt.
> +- dma-names: Two dmas have to be defined, "rx" and "tx".
> +       An ordered list of channel names affiliated to the above.

Please describe dmas in terms of dma-names (as with the patch describing
clocks and clock-names).

It would be nice to describe the type of the dmas property, but I see
that we have a propblem with inconsistent terminology in the area of
${THING}-specifiers, so I'll try to get that cleaned up separately.

Cheers,
Mark.
