From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Mar 2013 20:15:41 +0000
Subject: [GIT PULL 0/3] ARM: mvebu: changes for v3.10
Message-ID: <1363551341.dDc8Eea0.32562@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92629000ed5e1db9be062409038aa36de9c91eff:

  Merge branch 'next/spring-cleaning' into for-next

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git mvebu/for-next

for you to fetch changes up to 4e38c5c665d5dc2aa702631306e46dc6aec392de:

  Merge branch 'mvebu/soc' into mvebu/for-next

Jason Cooper (3):
      Merge branch 'mvebu/cleanup' into mvebu/for-next
      Merge branch 'mvebu/drivers' into mvebu/for-next
      Merge branch 'mvebu/soc' into mvebu/for-next

 .../devicetree/bindings/arm/mvebu-mbus.txt      |  39 +
 arch/arm/Kconfig                                |   4 +
 arch/arm/boot/dts/armada-370-xp.dtsi            |   5 -
 arch/arm/boot/dts/armada-370.dtsi               |   3 +
 arch/arm/boot/dts/armada-xp.dtsi                |   3 +
 arch/arm/boot/dts/dove.dtsi                     |   3 +-
 arch/arm/boot/dts/kirkwood.dtsi                 |   3 +-
 arch/arm/boot/dts/orion5x-88f5182.dtsi          |  18 +
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts |   2 +-
 arch/arm/mach-dove/Makefile                     |   2 +-
 arch/arm/mach-dove/addr-map.c                   | 125 ---
 arch/arm/mach-dove/board-dt.c                   |  13 +-
 arch/arm/mach-dove/common.c                     |  39 +-
 arch/arm/mach-dove/common.h                     |   2 +-
 arch/arm/mach-dove/include/mach/dove.h          |   5 +
 arch/arm/mach-kirkwood/Makefile                 |   2 +-
 arch/arm/mach-kirkwood/addr-map.c               |  91 --
 arch/arm/mach-kirkwood/board-dt.c               |  19 +-
 arch/arm/mach-kirkwood/common.c                 |  38 +-
 arch/arm/mach-kirkwood/common.h                 |   2 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h  |   7 +-
 arch/arm/mach-kirkwood/pcie.c                   |   1 -
 arch/arm/mach-mv78xx0/Makefile                  |   2 +-
 arch/arm/mach-mv78xx0/addr-map.c                |  93 --
 arch/arm/mach-mv78xx0/common.c                  |  10 +-
 arch/arm/mach-mv78xx0/include/mach/mv78xx0.h    |   8 +-
 arch/arm/mach-mv78xx0/pcie.c                    |  21 +-
 arch/arm/mach-mvebu/Kconfig                     |   1 +
 arch/arm/mach-mvebu/Makefile                    |   2 +-
 arch/arm/mach-mvebu/addr-map.c                  | 137 ---
 arch/arm/mach-mvebu/armada-370-xp.c             |   2 +
 arch/arm/mach-mvebu/platsmp.c                   |   2 +
 arch/arm/mach-orion5x/Makefile                  |   2 +-
 arch/arm/mach-orion5x/addr-map.c                | 155 ----
 arch/arm/mach-orion5x/board-dt.c                |  24 +-
 arch/arm/mach-orion5x/common.c                  |  49 +-
 arch/arm/mach-orion5x/common.h                  |  13 +-
 arch/arm/mach-orion5x/d2net-setup.c             |   4 +-
 arch/arm/mach-orion5x/db88f5281-setup.c         |  13 +-
 arch/arm/mach-orion5x/dns323-setup.c            |   3 +-
 arch/arm/mach-orion5x/edmini_v2-setup.c         |   4 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h    |   6 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c       |   8 +-
 arch/arm/mach-orion5x/ls-chl-setup.c            |   4 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c            |   4 +-
 arch/arm/mach-orion5x/lsmini-setup.c            |   4 +-
 arch/arm/mach-orion5x/mss2-setup.c              |   3 +-
 arch/arm/mach-orion5x/mv2120-setup.c            |   3 +-
 arch/arm/mach-orion5x/net2big-setup.c           |   4 +-
 arch/arm/mach-orion5x/pci.c                     |  14 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c    |   4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c     |   4 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c         |   7 +-
 arch/arm/mach-orion5x/terastation_pro2-setup.c  |   4 +-
 arch/arm/mach-orion5x/ts209-setup.c             |   4 +-
 arch/arm/mach-orion5x/ts409-setup.c             |   4 +-
 arch/arm/mach-orion5x/wnr854t-setup.c           |   4 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c        |   4 +-
 arch/arm/plat-orion/Makefile                    |   2 -
 arch/arm/plat-orion/addr-map.c                  | 178 ----
 arch/arm/plat-orion/pcie.c                      |  10 +-
 drivers/bus/Kconfig                             |   7 +
 drivers/bus/Makefile                            |   1 +
 drivers/bus/mvebu-mbus.c                        | 906 +++++++++++++++++++
 include/linux/mbus.h                            |  28 +-
 65 files changed, 1301 insertions(+), 887 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mvebu-mbus.txt
 create mode 100644 arch/arm/boot/dts/orion5x-88f5182.dtsi
 delete mode 100644 arch/arm/mach-dove/addr-map.c
 delete mode 100644 arch/arm/mach-kirkwood/addr-map.c
 delete mode 100644 arch/arm/mach-mv78xx0/addr-map.c
 delete mode 100644 arch/arm/mach-mvebu/addr-map.c
 delete mode 100644 arch/arm/mach-orion5x/addr-map.c
 delete mode 100644 arch/arm/plat-orion/addr-map.c
 create mode 100644 drivers/bus/mvebu-mbus.c
