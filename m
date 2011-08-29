From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Aug 2011 22:40:11 +0200
Subject: [GIT PULL] arm-soc fixes for 3.1-rc4
Message-ID: <2227519.rE44Tt1lqi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are a bunch of bug fixes that have accumulated since the ones
I sent you for -rc2. I had planned to send these last week already
but didn't get to it. The good news is that they've seen more testing
this way.

	Arnd

The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arm/linux-arm-soc.git/ fixes

Abhilash Kesavan (2):
      ARM: S5PV210: Fix build warning
      ARM: S3C64XX: Fix build break in PM debug

Arnd Bergmann (3):
      Merge branch 'samsung/fixes' of git+ssh://master.kernel.org/.../arm/linux-arm-soc into fixes
      Merge branch 'fixes' of git://git.jdl.com/software/linux-3.0 into fixes
      Merge branch 'at91/fixes' of git+ssh://master.kernel.org/.../arm/linux-arm-soc into fixes

Bryan Wu (2):
      ARM: mach-orion5x: add missing header file <linux/vga.h>
      ARM: mach-footbridge: add missing header file <video/vga.h>

Huang Weiyi (1):
      ARM: EXYNOS4: remove duplicated inclusion

Jean-Christophe PLAGNIOL-VILLARD (1):
      at91: at91sam9261.c: fix typo in t2_clk alias for atmel_tcb.0

Jonghwan Choi (1):
      ARM: EXYNOS4: Fix wrong devname to support clkdev

Kukjin Kim (2):
      ARM: S5P64X0: Replace irq_gc_ack() with irq_gc_ack_set_bit()
      ARM: SAMSUNG: Fix Section mismatch in samsung_bl_set()

Kyungmin Park (2):
      ARM: EXYNOS4: Use the correct regulator names on universal_c210
      ARM: EXYNOS4: Add restart hook for proper reboot

Marek Szyprowski (3):
      ARM: SAMSUNG: Add chained enrty/exit call to timer interrupt handler
      ARM: EXYNOS4: add required chained_irq_enter/exit to eint code
      ARM: S5P: add required chained_irq_enter/exit to gpio-int code

Naveen Krishna Chatradhi (1):
      ARM: S5P: fix bug in spdif_clk_get_rate

Paul Gortmaker (1):
      arm: fix compile failure in orion5x/dns323-setup.c

Sylwester Nawrocki (1):
      ARM: EXYNOS4: Fix the IRQ definitions for MIPI CSIS device

Yulgon Kim (1):
      ARM: EXYNOS4: Increase reset delay for USB HOST PHY

 arch/arm/mach-at91/at91sam9261.c               |    2 +-
 arch/arm/mach-exynos4/clock.c                  |    2 +-
 arch/arm/mach-exynos4/cpu.c                    |   11 ++++++++++-
 arch/arm/mach-exynos4/include/mach/irqs.h      |    5 ++---
 arch/arm/mach-exynos4/include/mach/regs-pmu.h  |    2 ++
 arch/arm/mach-exynos4/irq-eint.c               |    7 +++++++
 arch/arm/mach-exynos4/mach-universal_c210.c    |    4 ++--
 arch/arm/mach-exynos4/setup-usb-phy.c          |    2 +-
 arch/arm/mach-footbridge/dc21285.c             |    1 +
 arch/arm/mach-orion5x/dns323-setup.c           |    2 +-
 arch/arm/mach-orion5x/pci.c                    |    1 +
 arch/arm/mach-s3c64xx/pm.c                     |    1 +
 arch/arm/mach-s5p64x0/irq-eint.c               |    2 +-
 arch/arm/mach-s5pv210/pm.c                     |    2 +-
 arch/arm/plat-s5p/clock.c                      |    2 +-
 arch/arm/plat-s5p/irq-gpioint.c                |    6 ++++++
 arch/arm/plat-samsung/include/plat/backlight.h |    2 +-
 arch/arm/plat-samsung/irq-vic-timer.c          |    5 +++++
 18 files changed, 45 insertions(+), 14 deletions(-)
