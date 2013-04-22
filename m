From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Apr 2013 13:40:17 +0200
Subject: [PATCH 05/23] pinctrl: coh901: add device tree support
In-Reply-To: <1366624326-6259-1-git-send-email-linus.walleij@stericsson.com>
References: <1366624326-6259-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201304221340.18080.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013, Linus Walleij wrote:
> +Required properties:
> +- compatible: Compatible property value should be "stericsson,gpio-coh901"
> +- reg: Physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: the 0...n interrupts assigned to the different GPIO ports/banks.
> +- interrupt-names: name the interrupts after port/bank, "gpio0", "gpio1" etc.
> +

I think it would be better to leave out the interrupt-names in this case, since
the name directly corresponds to the index, so there is no ambiguity.

	Arnd
