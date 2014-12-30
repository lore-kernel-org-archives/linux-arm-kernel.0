From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 16:58:25 +0100
Subject: ARM: SoC fixes for 3.19-rc3
Message-ID: <5148069.JqHzJYRvtB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a few more known problems waiting for fixes, and there isn't much
in here, but arm64 is currently broken because of one missing patch, so
I'm sending this to flush our current patch queue while we're waiting
for other patches to come in, now that people start getting back to work.

	Arnd

---
The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 007487f1fd43d84f26cda926081ca219a24ecbc4:

  Add USB_EHCI_EXYNOS to multi_v7_defconfig (2014-12-30 16:03:53 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 3.19-rc3

A very small set of fixes for 3.19, as everyone was out. The clocksource
patch was something I missed for the merge window after the change that
broke arm64 was merged through arm-soc. The other two patches are
a fix for an undetected merge problem in mvebu and a defconfig change
to make some exynos boards work with the normal multi_v7_defconfig.

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'mvebu-fixes-3.19' of git://git.infradead.org/linux-mvebu into fixes

Catalin Marinas (1):
      clocksource: arch_timer: Only use the virtual counter (CNTVCT) on arm64

Gregory CLEMENT (1):
      ARM: mvebu: Fix pinctrl configuration for Armada 370 DB

Steev Klimaszewski (1):
      Add USB_EHCI_EXYNOS to multi_v7_defconfig

 arch/arm/boot/dts/armada-370-db.dts  | 24 ------------------------
 arch/arm/configs/multi_v7_defconfig  |  1 +
 drivers/clocksource/arm_arch_timer.c |  2 +-
 3 files changed, 2 insertions(+), 25 deletions(-)
