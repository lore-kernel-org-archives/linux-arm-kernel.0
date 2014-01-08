From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jan 2014 12:29:44 +0100
Subject: [PATCH v2 3/3] ARM: sun7i: irqchip: Update the documentation
In-Reply-To: <1389030097-10822-4-git-send-email-carlo.caione@gmail.com>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
 <1389030097-10822-4-git-send-email-carlo.caione@gmail.com>
Message-ID: <201401081229.45029.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 January 2014, Carlo Caione wrote:
> +Allwinner Sunxi NMI Controller
> +==============================
> +
> +Required properties:
> +
> +- compatible : should be "allwinner,sun7i-sc-nmi"
> +- reg : Specifies base physical address and size of the registers.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 2.

I think you should list what the two cells are so users know what to
put in the irq specifier.

> +sc-nmi-intc at 01c00030 {
> +       compatible = "allwinner,sun7i-sc-nmi";
> +       interrupt-controller;
> +       #interrupt-cells = <2>;
> +       reg = <0x01c00030 0x0c>;
> +       interrupt-parent = <&gic>;
> +       interrupts = <0 0 1>;
> +};

Is <0 0 1> the correct representation of the NMI? This question has recently
come up on IRC and I didn't know the answer at the time.

	Arnd
