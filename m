From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 24 May 2010 14:35:43 +0800
Subject: [PATCH 0/6] pxa: encode IRQ number into .nr_irqs (SPARSE IRQ)
Message-ID: <1274682949-25915-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of SPARSE_IRQ, the total number of IRQs (NR_IRQS)
can be made as a variable now. Conversion of most platforms looks to be
quite straight forward (as illustrated with the subsequent patches).
However, the platforms below select PXA_HAVE_BOARD_IRQS yet I feel hard
to find clues in the code if any of the board IRQs are used and how many.
Please advise:

$ git grep -B 5 PXA_HAVE_BOARD_IRQS arch/arm/mach-pxa/Kconfig

arch/arm/mach-pxa/Kconfig-	bool "Arcom/Eurotech VIPER SBC"
arch/arm/mach-pxa/Kconfig-	select PXA25x
arch/arm/mach-pxa/Kconfig-	select ISA
arch/arm/mach-pxa/Kconfig-	select I2C_GPIO
arch/arm/mach-pxa/Kconfig-	select HAVE_PWM
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-config MACH_ARCOM_ZEUS
arch/arm/mach-pxa/Kconfig-	bool "Arcom/Eurotech ZEUS SBC"
arch/arm/mach-pxa/Kconfig-	select PXA27x
arch/arm/mach-pxa/Kconfig-	select ISA
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-config MACH_INTELMOTE2
arch/arm/mach-pxa/Kconfig-	bool "Intel Mote 2 Platform"
arch/arm/mach-pxa/Kconfig-	select PXA27x
arch/arm/mach-pxa/Kconfig-	select IWMMXT
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-config MACH_STARGATE2
arch/arm/mach-pxa/Kconfig-	bool "Intel Stargate 2 Platform"
arch/arm/mach-pxa/Kconfig-	select PXA27x
arch/arm/mach-pxa/Kconfig-	select IWMMXT
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-config MACH_PCM027
arch/arm/mach-pxa/Kconfig-	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
arch/arm/mach-pxa/Kconfig-	select PXA27x
arch/arm/mach-pxa/Kconfig-	select IWMMXT
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-config MACH_MAGICIAN
arch/arm/mach-pxa/Kconfig-	bool "Enable HTC Magician Support"
arch/arm/mach-pxa/Kconfig-	select PXA27x
arch/arm/mach-pxa/Kconfig-	select IWMMXT
arch/arm/mach-pxa/Kconfig-	select HAVE_PWM
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-config MACH_TOSA
arch/arm/mach-pxa/Kconfig-	bool "Enable Sharp SL-6000x (Tosa) Support"
arch/arm/mach-pxa/Kconfig-	depends on PXA_SHARPSL
arch/arm/mach-pxa/Kconfig-	select PXA25x
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-	select PXA3xx
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-config ARCH_PXA_ESERIES
arch/arm/mach-pxa/Kconfig-	bool "PXA based Toshiba e-series PDAs"
arch/arm/mach-pxa/Kconfig-	select PXA25x
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-config MACH_ZIPIT2
arch/arm/mach-pxa/Kconfig-	bool "Zipit Z2 Handheld"
arch/arm/mach-pxa/Kconfig-	select PXA27x
arch/arm/mach-pxa/Kconfig-	select HAVE_PWM
arch/arm/mach-pxa/Kconfig:	select PXA_HAVE_BOARD_IRQS
--
arch/arm/mach-pxa/Kconfig-	  by either console keyboard driver or by Kdrive keybd driver.
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-	  Say Y only if you know, what you are doing!
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig-
arch/arm/mach-pxa/Kconfig:config PXA_HAVE_BOARD_IRQS
