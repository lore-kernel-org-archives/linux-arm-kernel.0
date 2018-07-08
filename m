From: olof@lixom.net (Olof Johansson)
Date: Sun, 8 Jul 2018 09:32:08 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20180708163208.hljszsjjt2q3jrt3@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to f0463f3619fd10e0cbaa5195bf2bc264a77a586d:

  Merge tag 'omap-for-v4.18/fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2018-07-05 14:59:20 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 4.18-rc

A small collection of fixes, sort of the usual at this point, all for
i.MX or OMAP:
 - Enable ULPI drivers on i.MX to avoid a hang
 - Pinctrl fix for touchscreen on i.MX51 ZII RDU1
 - Fixes for ethernet clock references on am3517
 - mmc0 write protect detection fix for am335x
 - kzalloc->kcalloc conversion in an OMAP driver
 - USB metastability fix for USB on dra7
 - Fix touchscreen wakeup on am437x

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: omap3: Fix am3517 mdio and emac clock references

Daniel Mack (1):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select ULPI support
      ARM: imx_v4_v5_defconfig: Select ULPI support

Kees Cook (1):
      bus: ti-sysc: Use 2-factor allocator arguments

Nick Dyer (1):
      ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl

Olof Johansson (2):
      Merge tag 'imx-fixes-4.18-2' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.18/fixes-signed' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Robert Nelson (1):
      ARM: dts: am335x-bone-common: Fix mmc0 Write Protect

Roger Quadros (1):
      ARM: dts: dra7: Disable metastability workaround for USB2

Tony Lindgren (1):
      Merge branch 'omap-for-v4.19/ti-sysc' into omap-for-v4.18/fixes

 arch/arm/boot/dts/am335x-bone-common.dtsi | 1 -
 arch/arm/boot/dts/am3517.dtsi             | 4 ++++
 arch/arm/boot/dts/am437x-sk-evm.dts       | 2 ++
 arch/arm/boot/dts/dra7.dtsi               | 2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts      | 2 +-
 arch/arm/configs/imx_v4_v5_defconfig      | 2 ++
 arch/arm/configs/imx_v6_v7_defconfig      | 2 ++
 drivers/bus/ti-sysc.c                     | 8 ++++----
 8 files changed, 16 insertions(+), 7 deletions(-)
