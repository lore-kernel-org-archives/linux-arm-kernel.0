From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 21 Nov 2018 10:41:01 -0600
Subject: [PATCH 2/3] dt-bindings: mfd: atmel-usart: add DMA bindings for
 SPI mode
In-Reply-To: <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
References: <20181121112732.15690-1-radu_nicolae.pirea@upb.ro>
 <20181121112732.15690-3-radu_nicolae.pirea@upb.ro>
Message-ID: <CAL_JsqLNURZTWCb5WOyJvN-trUP9r-ueftwUOGWPnrEaQPBKSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 5:29 AM Radu Pirea <radu_nicolae.pirea@upb.ro> wrote:
>
> The bindings for DMA are now common for both drivers of the USART
> IP.
>
> The node given as an example for USART in SPI mode has been updated in
> order to include DMA bindings.
>
> Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
> ---
>  .../devicetree/bindings/mfd/atmel-usart.txt       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> index 7f0cd72f47d2..8ad008175343 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> @@ -17,17 +17,19 @@ Required properties for USART in SPI mode:
>  - cs-gpios: chipselects (internal cs not supported)
>  - atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings/mfd/at91-usart.h)
>
> +Optional properties in serial and SPI mode:
> +- dma bindings for dma transfer:
> +       - dmas: DMA specifier, consisting of a phandle to DMA controller node,
> +               memory peripheral interface and USART DMA channel ID, FIFO configuration.
> +               Refer to dma.txt and atmel-dma.txt for details.
> +       - dma-names: "rx" for RX channel, "tx" for TX channel.

> +               dma-names = "tx", "rx";

The dma-names should have a defined order.

Rob
