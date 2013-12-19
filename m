From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Dec 2013 16:53:47 +0100
Subject: [PATCH] drivers/misc: atmel-ssc: document clock properties
In-Reply-To: <1387292507-6606-1-git-send-email-b.brezillon@overkiz.com>
References: <1387292507-6606-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52B3168B.10004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/2013 16:01, Boris BREZILLON :
> Document the clock properties required by the atmel-ssc driver.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  .../devicetree/bindings/misc/atmel-ssc.txt         |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> index a45ae08..60960b2 100644
> --- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> +++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
> @@ -6,6 +6,9 @@ Required properties:
>  	- atmel,at91sam9g45-ssc: support dma transfer
>  - reg: Should contain SSC registers location and length
>  - interrupts: Should contain SSC interrupt
> +- clock-names: tuple listing input clock names.
> +	Required elements: "pclk"
> +- clocks: phandles to input clocks.
>  
>  
>  Required properties for devices compatible with "atmel,at91sam9g45-ssc":
> @@ -20,6 +23,8 @@ ssc0: ssc at fffbc000 {
>  	compatible = "atmel,at91rm9200-ssc";
>  	reg = <0xfffbc000 0x4000>;
>  	interrupts = <14 4 5>;
> +	clocks = <&ssc0_clk>;
> +	clock-names = "pclk";
>  };
>  
>  - DMA transfer:
> 


-- 
Nicolas Ferre
