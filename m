From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 12 Nov 2017 19:19:30 +0100
Subject: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
In-Reply-To: <20171112154101.483d21d2@why.wild-wind.fr.eu.org>
References: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org>
 <20171112141349.6b4b3852@why.wild-wind.fr.eu.org>
 <CD4EBEF8-DDFD-40C3-A03E-7EC964B32357@martin.sperl.org>
 <20171112154101.483d21d2@why.wild-wind.fr.eu.org>
Message-ID: <20171112181930.GG30830@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +&spi {
> > +            status = "okay";
> > +
> > +            can0: mcp2517fd at 0 {
> > +                reg = <0>;
> > +                compatible = "microchip,mcp2517fd";
> > +                pinctrl-names = "default";
> > +                pinctrl-0 = <&can0_pins>;
> > +                spi-max-frequency = <12500000>;
> > +                interrupt-parent = <&gpio>;
> > +                interrupts = <16 0x2>;
> 
> This indicates a falling edge. No wonder the kernel is confused (I
> don't know why this isn't enforced the first time though, probably an
> issue in the GPIO irqchip driver...). Replacing this 2 with a 8 should
> allow you to make some progress.

And using IRQ_TYPE_LEVEL_LOW, from interrupt-controller/irq.h would
make it readable.

     Andrew
