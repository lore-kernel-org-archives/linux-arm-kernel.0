From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Nov 2018 09:10:23 -0800
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181107171023.zoo6qox5eewy3pmk@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please merge. Thanks!


-Olof

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to a89f84a56ec95fd66b839bf9c545f8a59a4ffcd5:

  Merge tag 'stratix10_dts_fix_for_v4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into fixes (2018-11-07 08:09:50 -0800)

----------------------------------------------------------------
ARM: SoC fixes

A few more fixes that have come in, and one revert of a previous fix.

I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
and it ended up regressing at least BeagleBone XM boards. While we get
that debugged for next merge window, let's disable it again.

Beyond that:

 - Stratix change to fix multicast filtering
 - Minor DT fixes for Renesas and i.MX
 - Ethernet fix for a Renesas board (switching main interfaces)
 - Ethernet phy regulator fix for i.MX6SX

----------------------------------------------------------------
Aaro Koskinen (1):
      arm64: dts: stratix10: fix multicast filtering

Fabrizio Castro (1):
      dt-bindings: arm: Fix RZ/G2E part number

Kuninori Morimoto (1):
      arm64: dts: renesas: r8a7795: add missing dma-names on hscif2

Leonard Crestez (1):
      ARM: dts: imx6sx-sdb: Fix enet phy regulator

Oleksij Rempel (1):
      ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c node

Olof Johansson (4):
      ARM: defconfig: Disable PREEMPT again on  multi_v7
      Merge tag 'imx-fixes-4.20' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'renesas-fixes-for-v4.20' of https://git.kernel.org/.../horms/renesas into fixes
      Merge tag 'stratix10_dts_fix_for_v4.20' of git://git.kernel.org/.../dinguyen/linux into fixes

Rob Herring (1):
      ARM: dts: fsl: Fix improperly quoted stdout-path values

Sergei Shtylyov (1):
      arm64: dts: renesas: condor: switch from EtherAVB to GEther

 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |  2 +-
 arch/arm/boot/dts/imx6sll.dtsi                     |  2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  7 +++-
 arch/arm/boot/dts/vf610m4-colibri.dts              |  4 +-
 arch/arm/configs/multi_v7_defconfig                |  1 -
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  3 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  2 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    | 47 +++++++++++-----------
 9 files changed, 39 insertions(+), 31 deletions(-)
