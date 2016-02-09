From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 16:14:32 +0100
Subject: [PATCH v3 01/12] irqchip: armada-370-xp: add Kconfig option for
 the driver
In-Reply-To: <1454951660-13289-2-git-send-email-gregory.clement@free-electrons.com>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
 <1454951660-13289-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <7747159.T9eeT0dC65@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 18:14:09 Gregory CLEMENT wrote:
> 
> +config ARMADA_370_XP_IRQ
> +       bool
> +       default y if ARCH_MVEBU
> +       select GENERIC_IRQ_CHIP
> +
> 

Looks good. I wonder if we should also enable this for COMPILE_TEST, e.g.

config ARMADA_370_XP_IRQ
       bool "Marvell Armada 3xx/XP/3xxx interrupt controller" if COMPILE_TEST && !ARCH_MVEBU
       default ARCH_MVEBU
       select GENERIC_IRQ_CHIP

If we do this, it's probably something outside of your series that we should
do for all patches, so don't worry about it here. Any opinions on the general
question?

	Arnd
