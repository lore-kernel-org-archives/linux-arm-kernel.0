From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 18 Oct 2010 17:20:38 +0200
Subject: [PATCH 1/7] arm/versatile: move pci code to plat-versatile
In-Reply-To: <1287072657-32477-2-git-send-email-arnd@arndb.de>
References: <1287072657-32477-1-git-send-email-arnd@arndb.de>
	<1287072657-32477-2-git-send-email-arnd@arndb.de>
Message-ID: <AANLkTik4StWAGR2eygMTT48Vbv-pjUjTcACBOQBMas6j@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/14 Arnd Bergmann <arnd@arndb.de>:

> The Xilinx PCI macro is used on both versatile-pb and
> realview-eb, so we should move the implementation to place
> where it can be shared.

> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? | ? ?5 +
> ?arch/arm/mach-versatile/Makefile ? ? | ? ?1 -
> ?arch/arm/mach-versatile/pci.c ? ? ? ?| ?361 ----------------------------------
> ?arch/arm/plat-versatile/Makefile ? ? | ? ?1 +
> ?arch/arm/plat-versatile/xilinx-pci.c | ?361 ++++++++++++++++++++++++++++++++++

What about arch/arm/common?

PCI drivers seem like they could be useful for others than ARM reference
designs too. Xilinx FPGAs are probably quite common anyway.

> (...)
> +obj-$(CONFIG_PCI_HOST_XILINX) += xilinx-pci.o
> diff --git a/arch/arm/plat-versatile/xilinx-pci.c b/arch/arm/plat-versatile/xilinx-pci.c
> new file mode 100644
> index 0000000..13c7e5f
> --- /dev/null
> +++ b/arch/arm/plat-versatile/xilinx-pci.c
> @@ -0,0 +1,361 @@
> +/*
> + * ?linux/arch/arm/mach-versatile/pci.c

Hm this file path seems inappropriate why not just delete it.

Yours,
Linus Walleij
