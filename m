From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 5 Nov 2013 17:18:16 +0100
Subject: [PATCH] ARM/serial: at91: specify RTS in DT using gpio
In-Reply-To: <A7887CC8-A1F9-4A05-B7F5-4F69FD942F22@jcrosoft.com>
References: <1383654959-18112-1-git-send-email-linus.walleij@linaro.org>
 <1383665383-5606-1-git-send-email-nicolas.ferre@atmel.com>
 <A7887CC8-A1F9-4A05-B7F5-4F69FD942F22@jcrosoft.com>
Message-ID: <20131105161816.GN6051@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 11:59:38PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> On Nov 5, 2013, at 11:29 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> > Documentation/devicetree/bindings/serial/atmel-usart.txt |  3 +++
> > drivers/tty/serial/atmel_serial.c                        | 13 ++++++++++---
> > 2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > index 2191dcb..3adc61c 100644
> > --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> > @@ -10,6 +10,8 @@ Required properties:
> > Optional properties:
> > - atmel,use-dma-rx: use of PDC or DMA for receiving data
> > - atmel,use-dma-tx: use of PDC or DMA for transmitting data
> > +- rts-gpios: specify a GPIO for RTS line. It will use specified PIO instead of the peripheral
> > +  function pin for the USART RTS feature. If unsure, don't specify this property.
> > - add dma bindings for dma transfer:
> > 	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
> > 		memory peripheral interface and USART DMA channel ID, FIFO configuration.
> > @@ -28,6 +30,7 @@ Example:
> > 		interrupts = <7>;
> > 		atmel,use-dma-rx;
> > 		atmel,use-dma-tx;
> > +		rts-gpios = <&pioD 15 0>;
> > 	};
> 
> gpios means 2 gpio 
> 
> I?ll rts-gpio as we can only use one anyway

Hi Jean

Have you read Documentation/devicetree/bindings/gpio/gpio.txt ?

It says:

GPIO properties should be named "[<name>-]gpios". Exact meaning of
each gpios property must be documented in the device tree binding for
each device.

There is also an example of a node with a single gpio using the
property name gpios. So plural is correct, even if there is only one
gpio.

	Andrew
