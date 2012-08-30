From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 30 Aug 2012 09:31:37 +0200
Subject: [PATCH RESEND 0/6] ARM: EXYNOS: Add support for Trats board using
 device tree
Message-ID: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds basic device tree support for Samsung Trats board
along with any necessary prerequisites.

In addition it refactors Exynos4 dts include files to split parts common to
the whole Exynos4 part from parts specific to Exynos4210 to allow further
extension of Exynos4210 dts include file and addition of include files for
other SoCs from Exynos4 line.

Dependencies:
-> [PATCH v5] mmc: sdhci-s3c: Add device tree support
http://www.spinics.net/lists/linux-samsung-soc/msg12056.html
-> [PATCH v5 2/2] regulator: add device tree support for max8997
http://www.spinics.net/lists/kernel/msg1328117.html

This is a resend, because previous messages somehow did not get to the mailing
lists.

Tomasz Figa (6):
  ARM: dts: Move parts common to Exynos4 from Exynos4210.dtsi to
    Exynos4.dtsi
  ARM: EXYNOS: exynos4-dt: Use exynos4 prefix instead of exynos4210
  ARM: Exynos4: dts: Specify address and size cells for i2c controllers
  ARM: Exynos4: Add OF compatibility lookups for Exynos4 i2c adapters
  ARM: EXYNOS: Increase maximum possible memory bank size to 512MiB
  ARM: Exynos: Add basic dts file for Samsung Trats board

 arch/arm/boot/dts/exynos4.dtsi             | 418 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210-trats.dts     | 287 ++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi          | 377 +-------------------------
 arch/arm/mach-exynos/Makefile.boot         |   2 +-
 arch/arm/mach-exynos/include/mach/memory.h |   4 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c     |  34 ++-
 6 files changed, 734 insertions(+), 388 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4210-trats.dts

-- 
1.7.12
