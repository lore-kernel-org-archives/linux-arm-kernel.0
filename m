From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 14:09:11 +0100
Subject: [PATCH v2 3/3] ARM: sun7i: irqchip: Update the documentation
In-Reply-To: <CAOQ7t2bg7qmwnQ-7iqbKCqK8fNS5GC=G0BN2188FQhPLN3v9VQ@mail.gmail.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
 <201401081229.45029.arnd@arndb.de>
 <CAOQ7t2bg7qmwnQ-7iqbKCqK8fNS5GC=G0BN2188FQhPLN3v9VQ@mail.gmail.com>
Message-ID: <14122384.i9DNmsOzpC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 12:49:10 Carlo Caione wrote:
> >> +sc-nmi-intc at 01c00030 {
> >> +       compatible = "allwinner,sun7i-sc-nmi";
> >> +       interrupt-controller;
> >> +       #interrupt-cells = <2>;
> >> +       reg = <0x01c00030 0x0c>;
> >> +       interrupt-parent = <&gic>;
> >> +       interrupts = <0 0 1>;
> >> +};
> >
> > Is <0 0 1> the correct representation of the NMI? This question has recently
> > come up on IRC and I didn't know the answer at the time.
> 
> Why shouldn't it be a correct representation? I think I missed the
> discussion on IRC.

For all I know, the NMI and the IRQ input to the CPU are separate pins,
so the NMI irqchip is not actually cascaded to the GIC, and SPI-0
might in fact be a different interrupt source.

	Arnd
