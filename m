From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Feb 2017 12:09:34 +0100
Subject: [PATCH 1/4] PCI: add DT bindings for Cortina Gemini PCI Host
 Bridge
In-Reply-To: <20170128204839.18330-1-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
Message-ID: <7079928.XO1j93ERJc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, January 28, 2017 9:48:36 PM CET Linus Walleij wrote:
> +       pci_intc: interrupt-controller {
> +               interrupt-controller;
> +               #address-cells = <0>;
> +               #interrupt-cells = <1>;
> +       };
> 


I think this one needs at least an interrupt-parent property, otherwise
you would recursively translate the numbers back through the interrupt-map
property of its parent.

	Arnd
