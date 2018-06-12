From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 17:03:33 -0500
Subject: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART
 controller
In-Reply-To: <20180612210640.GA20728@rob-hp-laptop>
References: <20180605060125.9518-1-nm@ti.com> <20180605060125.9518-4-nm@ti.com>
 <20180612210640.GA20728@rob-hp-laptop>
Message-ID: <20180612220333.4odussbccwmup26v@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:06-20180612, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
> > index 4b0f05adb228..c35d5ece1156 100644
> > --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
> > +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
> > @@ -1,6 +1,7 @@
> >  OMAP UART controller
> >  
> >  Required properties:
> > +- compatible : should be "ti,am654-uart" for AM654 controllers
> 
> Not compatible with any existing TI 8250 UARTs?

Base is compatible, however there are differences in DMA operation and
few additional bits. omap4-uart is sufficient for a basic PIO mode of
operation given initialization a bootloader might do for base console.

I will split the bindings off into it's own patch to keep the confusion
to a minimum and allowing serial driver change to go in independently.

-- 
Regards,
Nishanth Menon
