From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Aug 2012 10:02:58 +0200
Subject: [PATCH 03/14] arm: at91: at91sam9x5: fix gpio number per bank
In-Reply-To: <201208182118.45349.arnd@arndb.de>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-3-git-send-email-plagnioj@jcrosoft.com>
 <201208182118.45349.arnd@arndb.de>
Message-ID: <20120820080258.GG7439@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:18 Sat 18 Aug     , Arnd Bergmann wrote:
> On Friday 10 August 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > --- a/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
> > +++ b/Documentation/devicetree/bindings/gpio/gpio_atmel.txt
> > @@ -9,6 +9,10 @@ Required properties:
> >    unused).
> >  - gpio-controller: Marks the device node as a GPIO controller.
> >  
> > +optional properties:
> > +- gpio-nb: Number of gpio if absent 32.
> > +
> > +
> >  Example:
> >         pioA: gpio at fffff200 {
> >                 compatible = "atmel,at91rm9200-gpio";
> > @@ -16,5 +20,6 @@ Example:
> >                 interrupts = <2 4>;
> >                 #gpio-cells = <2>;
> >                 gpio-controller;
> > +               gpio-nb = <19>;
> 
> What does "nb" stand for?
> 
> The marvell-gpio binding uses "ngpio" for the number, so that would
> already be established. Otherwise, I think "#gpio-lines" would be
> more in line with other things we count in the bindings.
ngpio I dont like
#gpio-lines ok

Best Regards,
J.
