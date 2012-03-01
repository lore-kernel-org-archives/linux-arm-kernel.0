From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:42 -0500
Subject: [PATCH 0/8] ARM: Tegra: cleanup patches from Arnd Bergmann
Message-ID: <1330630010-11241-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm helping Arnd Bergmann get some of his cleanup patches upstream. This
set covers the Tegra.

Thanks,

Alan.

Arnd Bergmann (8):
  ARM: tegra: export tegra_gpio_{en,dis}able
  ARM: tegra: do not hide dma declarations
  ARM: tegra: select CPU_FREQ_TABLE
  ARM: tegra: build localtimer support only when needed
  ARM: tegra: work around tegra THUMB2_KERNEL bug
  ARM: tegra: USB_ULPI needs USB
  ARM: tegra: export usb phy symbols
  ARM: tegra: HACK: remove set_irq_flags() from driver

 arch/arm/Kconfig                       |    1 +
 arch/arm/mach-tegra/Kconfig            |    2 ++
 arch/arm/mach-tegra/Makefile           |    3 ++-
 arch/arm/mach-tegra/include/mach/dma.h |    4 ----
 arch/arm/mach-tegra/usb_phy.c          |   10 ++++++++++
 drivers/gpio/gpio-tegra.c              |    2 ++
 drivers/usb/host/ehci-tegra.c          |    1 -
 7 files changed, 17 insertions(+), 6 deletions(-)
