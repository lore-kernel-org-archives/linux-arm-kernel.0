From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Mar 2014 15:48:22 +0800
Subject: [GIT PULL 1/2] ARM: Keystone DTS updates for 3.15
Message-ID: <1394005703-6624-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Please pull below keystone DTS updates for 3.15. It merges cleanly with
arm-soc 'for-next' and 'next/dt' heads.

Please note that you get a trivial merge conflict while merging to the
latest Linus tip, because of bug fix commit 565bbdcd3b{ARM: keystone:
dts: fix clkvcp3 control register address} which got merged post
3.14-rc5. If it needs to be avoided then I need to rebase the PULL
request on top of 3.14-rc6 when it gets tagged. Do let me know if
thats needed.

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts

for you to fetch changes up to 82c04f71ecacf225cdd0ea96ec91f28ca9db70a1:

  ARM: dts: keystone: add AEMIF/NAND device entry (2014-02-28 21:05:24 -0500)

----------------------------------------------------------------
Keystone DTS updates for 3.15

- Add watchdog timer, timer64 and gpio device nodes
- Add LED device nodes
- Fixes for debugss, msmc clock nodes
- Add support for Keystone Lamarr and Edision SOC/EVM support
- Add NAND and AEMIF device nodes

----------------------------------------------------------------
Grygorii Strashko (3):
      ARM: dts: keystone: add gpio device entry
      ARM: dts: k2hk-evm: add leds supports
      ARM: dts: k2hk-evm: rename clock node to clocks

Ivan Khoronzhuk (4):
      ARM: dts: keystone: add watchdog entry
      ARM: dts: keystone: add keystone timer entry
      ARM: dts: keystone: drop msmcsram clock node
      ARM: dts: keystone: add AEMIF/NAND device entry

Murali Karicheri (5):
      ARM: dts: keystone: fix domain id for clkdebugsstrc
      ARM: dts: keystone: update for supporting K2L/K2E EVMs
      ARM: dts: keystone: preparatory patch to support K2L and K2E SOCs
      ARM: dts: keystone: add support for K2 Lamarr SoC and EVM
      ARM: dts: keystone: add support for k2 Edison SoC and EVM

 .../devicetree/bindings/arm/keystone/keystone.txt  |   10 +
 arch/arm/boot/dts/k2e-clocks.dtsi                  |   78 ++++
 arch/arm/boot/dts/k2e-evm.dts                      |   60 +++
 arch/arm/boot/dts/k2e.dtsi                         |   80 ++++
 arch/arm/boot/dts/k2hk-clocks.dtsi                 |  426 +++++++++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts                     |   83 +++-
 arch/arm/boot/dts/k2hk.dtsi                        |   46 +++
 arch/arm/boot/dts/k2l-clocks.dtsi                  |  267 ++++++++++++
 arch/arm/boot/dts/k2l-evm.dts                      |   37 ++
 arch/arm/boot/dts/k2l.dtsi                         |   55 +++
 arch/arm/boot/dts/keystone-clocks.dtsi             |  427 +-------------------
 arch/arm/boot/dts/keystone.dtsi                    |  102 +++--
 arch/arm/mach-keystone/keystone.c                  |    3 +
 13 files changed, 1224 insertions(+), 450 deletions(-)
 create mode 100644 arch/arm/boot/dts/k2e-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2e-evm.dts
 create mode 100644 arch/arm/boot/dts/k2e.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-evm.dts
 create mode 100644 arch/arm/boot/dts/k2l.dtsi
