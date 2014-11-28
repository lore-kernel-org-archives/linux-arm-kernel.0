From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 14:42:34 +0100
Subject: ARM: SoC fixes for 3.18-rc7
Message-ID: <201411281442.35201.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Not much interesting going on fixes-wise for us this week, as it should be
for an -rc7. I'm not expecting Olof to work much over Thanksgiving weekend,
so I decided to take over again and push these out to you.

	Arnd

The following changes since commit 5d01410fe4d92081f349b013a2e7a95429e4f2c9:

  Linux 3.18-rc6 (2014-11-23 15:25:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc tags/armsoc-for-rc7

for you to fetch changes up to 96ba18ffd09cc063b8d1ddc8c6cafea6177c8259:

  Merge tag 'mvebu-fixes-3.18-2' of git://git.infradead.org/linux-mvebu into fixes (2014-11-27 14:29:23 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 3.18-rc7

Just four simple fixes this week:

- one missing of_node_put() on armv7 based mvebu
- forcing the USB host into the right mode on Chromebook (exynos5-snow)
- enabling two important drivers for exynos_defconfig
- fixing a noncritical bug for tegra that would cause a
  regression with common code patches queued for 3.19

----------------------------------------------------------------
Arnd Bergmann (3):
      Merge tag 'samsung-fixes-v3.18' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'samsung-defconfig-v3.18' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'mvebu-fixes-3.18-2' of git://git.infradead.org/linux-mvebu into fixes

Javier Martinez Canillas (1):
      ARM: exynos_defconfig: Enable max77802 rtc and clock drivers

Marc Zyngier (1):
      ARM: tegra: irq: fix buggy usage of irq_data irq field

Sjoerd Simons (1):
      ARM: dts: Explicitly set dr_mode on exynos5250-snow

Thomas Petazzoni (1):
      ARM: mvebu: add missing of_node_put() call in coherency.c

 arch/arm/boot/dts/exynos5250-snow.dts |  4 ++++
 arch/arm/boot/dts/exynos5250.dtsi     |  2 +-
 arch/arm/configs/exynos_defconfig     |  2 ++
 arch/arm/mach-mvebu/coherency.c       |  2 ++
 arch/arm/mach-tegra/irq.c             | 22 +++++++++++-----------
 5 files changed, 20 insertions(+), 12 deletions(-)
