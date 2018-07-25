From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 25 Jul 2018 18:23:38 +0200
Subject: [GIT PULL 1/3] drivers: samsung: Cleanup for v4.19
Message-ID: <20180725162340.7488-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Rebased on v4.18-rc2, because at v4.18-rc1 the NFS root boot, which I use at my
testing setup (https://krzk.eu), was broken.

Best regards,
Krzysztof


The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos5440-4.19

for you to fetch changes up to c708e462e90e04afb7634e1f27f60cd6869936db:

  usb: host: exynos: Remove support for Exynos5440 (2018-07-24 18:44:00 +0200)

----------------------------------------------------------------
Exynos5440 drivers removal

The Exynos5440 (quad-core A15 with GMAC, PCIe, SATA) was targeting
server platforms but it did not make it to the market really.  There are
no development boards with it and probably there are no real products
neither.  The development for Exynos5440 ended in 2013 and since then
the platform is in maintenance mode.

Removing Exynos5440 makes our life slightly easier: less maintenance,
smaller code, reduced number of quirks, no need to preserve DTB
backward-compatibility.

The Device Tree sources and some of the drivers for Exynos5440 were
already removed.  This removes remaining drivers.

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      ata: ahci-platform: Remove support for Exynos5440
      cpufreq: exynos: Remove support for Exynos5440
      clk: samsung: Remove support for Exynos5440
      usb: host: exynos: Remove support for Exynos5440

 .../devicetree/bindings/ata/ahci-platform.txt      |   1 -
 .../devicetree/bindings/clock/exynos5440-clock.txt |  28 --
 .../bindings/cpufreq/cpufreq-exynos5440.txt        |  28 --
 drivers/ata/ahci_platform.c                        |   1 -
 drivers/clk/samsung/Makefile                       |   1 -
 drivers/clk/samsung/clk-exynos5440.c               | 167 --------
 drivers/cpufreq/Kconfig.arm                        |  14 -
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/exynos5440-cpufreq.c               | 452 ---------------------
 drivers/usb/host/ehci-exynos.c                     |   7 -
 drivers/usb/host/ohci-exynos.c                     |   6 -
 include/dt-bindings/clock/exynos5440.h             |  44 --
 12 files changed, 750 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos5440-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
 delete mode 100644 drivers/clk/samsung/clk-exynos5440.c
 delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c
 delete mode 100644 include/dt-bindings/clock/exynos5440.h
