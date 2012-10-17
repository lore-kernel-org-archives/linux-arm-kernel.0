From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Oct 2012 19:25:12 +0000
Subject: [GIT PULL 0/3] ARM: mvebu/kirkwood/dove fixes for v3.7
Message-ID: <pull-1350501943-114231>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_merge_test_for_v3.7

for you to fetch changes up to 624e773fdcb50ffc27dfb899644d5c0824ae506c:

  Merge branch 'v3.7-rc1/mvebu/gpio-fixes' into v3.7-rc1/merge-test (2012-10-17 18:19:07 +0000)

----------------------------------------------------------------

Depends:
 - Based on v3.7-rc1

Adds:
 - late fixes for dove
 - gpio fix for mvebu
 - cache build fix for kirkwood

Merge conflicts:
 - none observed

I'm trying out using a 'merge-test' branch as a kind of summary for when I send
multiple pull requests.  There's *no* need to pull this branch, it's purely
informational.

----------------------------------------------------------------
Axel Lin (1):
      gpio: mvebu: Add missing breaks in mvebu_gpio_irq_set_type

Jason Cooper (2):
      Merge branch 'v3.7-rc1/kirkwood/cache-build-fix' into v3.7-rc1/merge-test
      Merge branch 'v3.7-rc1/mvebu/gpio-fixes' into v3.7-rc1/merge-test

Jason Gunthorpe (1):
      Build failure CONFIG_ARCH_KIRKWOOD_DT relies on CACHE_FEROCEON_L2

Sebastian Hesselbarth (6):
      ARM: dove: Add pcie clock support
      ARM: dove: Fix tauros2 device tree init
      ARM: dove: Fix clock names of sata and gbe
      ARM: dove: Restructure SoC device tree descriptor
      ARM: dove: Remove watchdog from DT
      ARM: dove: Add crypto engine to DT

 arch/arm/boot/dts/dove.dtsi       | 49 +++++++++++++++++++++++++--------------
 arch/arm/mach-dove/common.c       |  8 +++----
 arch/arm/mach-dove/pcie.c         |  5 ++++
 arch/arm/mach-kirkwood/board-dt.c |  2 --
 arch/arm/mach-kirkwood/common.c   |  4 ++--
 drivers/gpio/gpio-mvebu.c         |  3 +++
 6 files changed, 46 insertions(+), 25 deletions(-)
