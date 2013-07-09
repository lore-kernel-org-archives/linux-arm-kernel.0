From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 9 Jul 2013 11:17:00 +0200
Subject: [PATCH 1/7] serial: at91: correct definition from DMA to PDC
In-Reply-To: <51DBC24E.9060601@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
 <1373351626-30143-2-git-send-email-elen.song@atmel.com>
 <20130709073155.GB4013@ludovic.desroches@atmel.com>
 <51DBC24E.9060601@atmel.com>
Message-ID: <20130709091700.GD4013@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 03:57:02PM +0800, elen.song wrote:
> On 7/9/2013 3:31 PM, Ludovic Desroches wrote:
> >Hi Elen,
> >
> >One comment below:
> >
> >On Tue, Jul 09, 2013 at 02:33:40PM +0800, Elen Song wrote:
> >
> >[...]
> >
> >>diff --git a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> >>index a49d9a1..82f45ec 100644
> >>--- a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> >>+++ b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> >>@@ -8,8 +8,8 @@ Required properties:
> >>  - interrupts: Should contain interrupt
> >>  Optional properties:
> >>-- atmel,use-dma-rx: use of PDC or DMA for receiving data
> >>-- atmel,use-dma-tx: use of PDC or DMA for transmitting data
> >>+- atmel,use-pdc-rx: use of PDC for receiving data
> >>+- atmel,use-pdc-tx: use of PDC for transmitting data
> >>  <chip> compatible description:
> >>  - at91rm9200:  legacy USART support
> >>@@ -19,9 +19,9 @@ Example:
> >>  	usart0: serial at fff8c000 {
> >>  		compatible = "atmel,at91sam9260-usart";
> >>-		reg = <0xfff8c000 0x4000>;
> >>-		interrupts = <7>;
> >>-		atmel,use-dma-rx;
> >>-		atmel,use-dma-tx;
> >>+		reg = <0xfff8c000 0x200>;
> >>+		interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
> >Maybe put these changes into an other patch since it is not in relation with
> >the purpose of your patch.
> >
> >Moreover, I am not sure that macros should be used in the documentation. From
> >the top of my head, there was a discussion about that and the status was to not
> >use macros in documentation since it is Linux dependant.
> 
> Ok, I will not involve the macros in the document now.
> So I will move all the document changes into the last patch, right?

Documentation update is ok excepting the reg field change which should be in a
fixup patch since it is not related to the introduction of use-pdc-*.

> >
> >>+		atmel,use-pdc-rx;
> >>+		atmel,use-pdc-tx;
> >>  	};
> >[...]
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
