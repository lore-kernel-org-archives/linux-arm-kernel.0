From: alan@signal11.us (Alan Ott)
Date: Fri,  2 Mar 2012 15:58:04 -0500
Subject: [PATCH v2 0/6] ARM: Tegra: cleanup patches from Arnd Bergmann
Message-ID: <1330721884-8495-1-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the mess yesterday....
This is V2 of Arnd's Patch series from yesterday. Hopefully this one will be
smoother.

Changes:
	* set_irq_flags() removal patch is out
	* driver-only patch has been moved to another set
	* Distribution list should be cleaner
	* Added proper sign-off
	* Select CPU_FREQ_TABLE for ARCH_TEGRA_3x_SOC as well
	* Fixed spacing on the localtimer patch
	* added linux/export.h to the export usb phy symbols patch

Arnd Bergmann (6):
  ARM: tegra: do not hide dma declarations
  ARM: tegra: select CPU_FREQ_TABLE
  ARM: tegra: build localtimer support only when needed
  ARM: tegra: work around tegra THUMB2_KERNEL bug
  ARM: tegra: USB_ULPI needs USB
  ARM: tegra: export usb phy symbols

 arch/arm/Kconfig                       |    1 +
 arch/arm/mach-tegra/Kconfig            |    3 +++
 arch/arm/mach-tegra/Makefile           |    3 ++-
 arch/arm/mach-tegra/include/mach/dma.h |    4 ----
 arch/arm/mach-tegra/usb_phy.c          |   11 +++++++++++
 5 files changed, 17 insertions(+), 5 deletions(-)
