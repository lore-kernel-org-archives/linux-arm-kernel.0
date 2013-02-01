From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 1 Feb 2013 15:51:59 +0000
Subject: [GIT PULL  2/4] ARM: mvebu: drivers for v3.9
In-Reply-To: <1359733918.Bf7ecc0.22262@triton>
Message-ID: <1359733919.FCB62.22262@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/drivers_for_v3.9

for you to fetch changes up to 9cfc94eb0f4843af5d1141a37d7b7ca5d3b27220:

  cpuidle: kirkwood: Move out of mach directory

----------------------------------------------------------------
mvebu drivers for v3.9
     - use rtc-mv in mvebu armv7 SoCs
     - add pci-e hotplug for kirkwood
    
    Depends on:
     - tags/mvebu_fixes_for_v3.8-rc6
----------------------------------------------------------------
Andrew Lunn (1):
      cpuidle: kirkwood: Move out of mach directory

Gregory CLEMENT (1):
      rtc: Add support of rtc-mv for MVEBU SoCs

Jason Cooper (1):
      Merge tag 'tags/mvebu_fixes_for_v3.8-rc6' into mvebu/drivers

Jason Gunthorpe (1):
      ARM: Kirkwood: Support basic hotplug for PCI-E

 arch/arm/boot/dts/dove.dtsi                     |  2 +
 arch/arm/configs/kirkwood_defconfig             |  1 +
 arch/arm/configs/mvebu_defconfig                |  2 +
 arch/arm/mach-kirkwood/Makefile                 |  1 -
 arch/arm/mach-kirkwood/board-dt.c               |  2 +
 arch/arm/mach-kirkwood/common.c                 | 23 ++++++++++
 arch/arm/mach-kirkwood/common.h                 |  1 +
 arch/arm/mach-kirkwood/include/mach/kirkwood.h  |  3 +-
 arch/arm/mach-kirkwood/pcie.c                   | 10 ++---
 arch/arm/plat-orion/mpp.c                       |  2 +-
 drivers/cpuidle/Kconfig                         |  6 +++
 drivers/cpuidle/Makefile                        |  1 +
 .../cpuidle/cpuidle-kirkwood.c                  | 45 +++++++++++++++++---
 drivers/rtc/Kconfig                             |  2 +-
 14 files changed, 84 insertions(+), 17 deletions(-)
 rename arch/arm/mach-kirkwood/cpuidle.c => drivers/cpuidle/cpuidle-kirkwood.c (61%)
