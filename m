From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 17:08:05 +0100
Subject: [PATCH v2] irqchip: irq-mvebu-odmi: new driver for platform MSI
 on Marvell 7K/8K
In-Reply-To: <1455811134-3679-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455811134-3679-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <3923904.c50oLNXXZ1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 16:58:54 Thomas Petazzoni wrote:
> +- marvell,spi-base     : List of GIC base SPI interrupts, one for each
> +                         ODMI frame. Those SPI interrupts are 0-based,
> +                         i.e marvell,spi-base = <128> will use SPI #96.
> +                         See Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
> +                         for details about the GIC Device Tree binding.
> 

Why are these not just in an 'interrupts' property as we do for other
nested irqchips?

	Arnd
