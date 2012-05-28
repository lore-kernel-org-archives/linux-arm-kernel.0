From: rubini@gnudd.com (Alessandro Rubini)
Date: Mon, 28 May 2012 10:17:37 +0200
Subject: amba, tegra-ahb and pci (Kconfig question)
Message-ID: <20120528081737.GA8031@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

I plan to submit drivers/amba/apb-pci.c (and later ahb-pci.c), because
the amba-pl011-pci.c I proposed is actually a generic bridge and there
are several such devices in my chip.

I planned to use obj-$(CONFIG_PCI) in drivers/amba/Makefile, but 
commit 87d0bab2cba3c31624b80cc68bcf5e29ef969458 had this in drivers/Makefile:

  -obj-$(CONFIG_ARM_AMBA)         += amba/
  +obj-y                          += amba/

So I ask how to proceed. Shall I define CONFIG_PCI_AMBA or something
like that, or should drivers/amba/tegra-ahb.c be moved to
arch/arm/mach-tegra ?  (I prefer the latter and can submit such patch,
but not without authorization from the involved parties).

If the former (CONFIG_PCI_AMBA), where should the symbol be defined?
My personal preference is doing it like this, plus help message:

   config PCI_AMBA
          bool "PCI-to-AMBA bridge"
          depends on ARM_AMBA && PCI

In this case, shall I name CONFIG_STA2X11 in the depends, or in the
help message, or I'd better be generic, knowing someone else will soon
have similar things?

Thanks
/alessandro
