From: hatim.rv@samsung.com (Hatim Ali)
Date: Fri, 26 Aug 2011 12:09:05 +0530
Subject: [PATCH 0/2] Add TVOUT support for SMDKV310
Message-ID: <1314340747-13816-1-git-send-email-hatim.rv@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds TVOUT support for SMDKV310 board.

These patches are based on Tomasz Stanislawski's patchset
"Updated s5p-tv platform definitions"
(http://www.spinics.net/lists/linux-samsung-soc/msg06138.html)
and "add support for HDMIPHY dedicated controller"
(http://www.spinics.net/lists/linux-i2c/msg05932.html)
on for-next branch of kgene's tree
(git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git)

The TVOUT driver has a dependency on PM_RUNTIME. So you need to
enable the PM_RUNTIME support in "Power Management" option in
menuconfig.

These patches have been tested for 720x480 and 1280x720 resolutions
on SMDKV310 EVT1.

The SDO functionality has not been tested because it has a
dependency on PMIC support. Once PMIC support is added,
SDO can also be tested.

NOTE: Patch 2 is for testing TVOUT driver on SMDKV310 till CMA
support gets merged.

Hatim Ali (2):
  ARM: EXYNOS4: Add TVOUT support for SMDKV310
  ARM: EXYNOS4: Update consistent DMA size to 8MB

 arch/arm/mach-exynos4/Kconfig               |    2 ++
 arch/arm/mach-exynos4/include/mach/memory.h |    1 +
 arch/arm/mach-exynos4/mach-smdkv310.c       |    5 +++++
 3 files changed, 8 insertions(+), 0 deletions(-)

--
1.7.2.3
