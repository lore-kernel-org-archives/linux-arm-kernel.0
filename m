From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2012 17:24:44 +0000
Subject: [PATCH 1/2] serial/imx: add DMA support
In-Reply-To: <1335436632-29499-2-git-send-email-b32955@freescale.com>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
 <1335436632-29499-2-git-send-email-b32955@freescale.com>
Message-ID: <201204271724.45435.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 April 2012, Huang Shijie wrote:
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> index a9c0406..f27489d 100644
> --- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> @@ -8,6 +8,10 @@ Required properties:
>  Optional properties:
>  - fsl,uart-has-rtscts : Indicate the uart has rts and cts
>  - fsl,irda-mode : Indicate the uart supports irda mode
> +- fsl,enable-dma : Indicate the uart supports DMA
> +- fsl,uart-dma-events : contains the DMA events for RX and TX,
> +                 The first is the RX event, while the other is TX.
> +- fsl,enable-dte: Indicate the uart works in DTE mode
>  

I think we should not add any ad-hoc DMA bindings for device drivers
until we have a proper generic binding for DMA.

	Arnd
