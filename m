From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 29 Jan 2013 18:34:10 +0000
Subject: [GIT PULL] vexpress: drivers for v3.9
Message-ID: <1359484450.8090.27.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/drivers-for-3.9

for you to fetch changes up to d299d4b5c95d37df0a8964930a3586f8d3cdb4ef:

  arm: Move sp810.h to include/linux/amba/ (2013-01-29 18:13:24 +0000)

----------------------------------------------------------------
Versatile Express related driver updates for 3.9:
* Move sp810 header to a more generic location,
  mainly to share it with arm64
* Add pseudo-GPIO lines (and equivalent gpio LED definitions)
  to control LEDs on vexpress motherboard.

----------------------------------------------------------------
Catalin Marinas (1):
      arm: Move sp810.h to include/linux/amba/

Pawel Moll (1):
      mfd: vexpress: Add pseudo-GPIO based LEDs

 arch/arm/plat-spear/restart.c                      |    2 +-
 drivers/clk/versatile/clk-vexpress.c               |    3 +-
 drivers/mfd/vexpress-sysreg.c                      |   73 +++++++++++++++-----
 .../asm/hardware => include/linux/amba}/sp810.h    |    0
 include/linux/vexpress.h                           |    8 +++
 5 files changed, 65 insertions(+), 21 deletions(-)
 rename {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h (100%)
