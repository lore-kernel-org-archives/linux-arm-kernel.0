From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 30 Jul 2015 15:36:09 +0200
Subject: [PATCH v1 1/2] dt: atmel-usart: document new I/O data register
 width property
In-Reply-To: <1438261591-13130-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438261591-13130-1-git-send-email-andriy.shevchenko@linux.intel.com>
Message-ID: <55BA2849.2050803@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/07/2015 15:06, Andy Shevchenko a ?crit :
> This change documents a new property for the Atmel serial device, allowing an
> implementer to specify either four bytes or one byte access to the controller
> data register.
> 
> This supports a change that unbreaks this driver on ATNGW100 board.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/devicetree/bindings/serial/atmel-usart.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> index e6e6142..a8c290a7 100644
> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> @@ -6,6 +6,8 @@ Required properties:
>    additional mode or an USART new feature.
>    For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
>  - reg: Should contain registers location and length
> +- reg-io-width: The I/O register width (in bytes) implemented by
> +  this device. Supported values are 1 or 4 (the default).

Well, sorry but no.
The proper way to implement this is to cling to certain compatible
strings. But I'm pretty sure that this issue shall not be fixed like this.

But I think that Cyrille is about to propose another version. Let's wait
for his code...

Bye,


>  - interrupts: Should contain interrupt
>  - clock-names: tuple listing input clock names.
>  	Required elements: "usart"
> 


-- 
Nicolas Ferre
