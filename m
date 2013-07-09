From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 9 Jul 2013 13:21:52 +0200
Subject: [PATCH 1/7] serial: at91: correct definition from DMA to PDC
In-Reply-To: <20130709073155.GB4013@ludovic.desroches@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
 <1373351626-30143-2-git-send-email-elen.song@atmel.com>
 <20130709073155.GB4013@ludovic.desroches@atmel.com>
Message-ID: <20130709112152.GA18012@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:31 Tue 09 Jul     , Ludovic Desroches wrote:
> Hi Elen,
> 
> One comment below:
> 
> On Tue, Jul 09, 2013 at 02:33:40PM +0800, Elen Song wrote:
> 
> [...]
> 
> > diff --git a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> > index a49d9a1..82f45ec 100644
> > --- a/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> > +++ b/Documentation/devicetree/bindings/tty/serial/atmel-usart.txt
> > @@ -8,8 +8,8 @@ Required properties:
> >  - interrupts: Should contain interrupt
> >  
> >  Optional properties:
> > -- atmel,use-dma-rx: use of PDC or DMA for receiving data
> > -- atmel,use-dma-tx: use of PDC or DMA for transmitting data
> > +- atmel,use-pdc-rx: use of PDC for receiving data
> > +- atmel,use-pdc-tx: use of PDC for transmitting data
> >  
> >  <chip> compatible description:
> >  - at91rm9200:  legacy USART support
> > @@ -19,9 +19,9 @@ Example:
> >  
> >  	usart0: serial at fff8c000 {
> >  		compatible = "atmel,at91sam9260-usart";
> > -		reg = <0xfff8c000 0x4000>;
> > -		interrupts = <7>;
> > -		atmel,use-dma-rx;
> > -		atmel,use-dma-tx;
> > +		reg = <0xfff8c000 0x200>;
> > +		interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;

> 
> Maybe put these changes into an other patch since it is not in relation with
> the purpose of your patch.
> 
> Moreover, I am not sure that macros should be used in the documentation. From
> the top of my head, there was a discussion about that and the status was to not
> use macros in documentation since it is Linux dependant.

yes you are right

Best Regards,
J.
> 
> > +		atmel,use-pdc-rx;
> > +		atmel,use-pdc-tx;
> >  	};
> >  
> 
> [...]
