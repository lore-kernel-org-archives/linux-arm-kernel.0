From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Nov 2016 17:00:27 +0800
Subject: [GIT PULL 1/5] i.MX non-critical fixes for 4.10
Message-ID: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fix-nc-4.10

for you to fetch changes up to 72649a46067903d00f46e2ebef6543768224f1a0:

  ARM: dts: imx6q-cm-fx6: fix fec pinctrl (2016-11-14 15:31:01 +0800)

----------------------------------------------------------------
i.MX non-critical fixes for 4.10:
 - A series from Vladimir to fix broken i.MX31 DT clock initialization.
   As i.MX31 DT support is still not quite complete, the changes are
   tested on qemu kzm target and mx31lite board with simple written DTS
   files.
 - A fix for CompuLab's sbc-fx6 baseboard to remove wrong fec pinctrl
   setting.
 - A DTS correction for i.MX6QP to reflect the change that the gate of
   LDB clock has been moved before the divider.
 - An imx7d-pinfunc fix for UART pinmux defines

----------------------------------------------------------------
Christopher Spinrath (1):
      ARM: dts: imx6q-cm-fx6: fix fec pinctrl

Lucas Stach (1):
      ARM: dts: imx6qp: correct LDB clock inputs

Stefan Agner (1):
      ARM: dts: imx7d-pinfunc: fix UART pinmux defines

Vladimir Zapolskiy (4):
      ARM: dts: imx31: fix clock control module interrupts description
      ARM: dts: imx31: move CCM device node to AIPS2 bus devices
      clk: imx31: fix rewritten input argument of mx31_clocks_init()
      ARM: clk: imx31: properly init clocks for machines with DT

 .../devicetree/bindings/clock/imx31-clock.txt      |  2 +-
 arch/arm/boot/dts/imx31.dtsi                       | 14 +++---
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  1 -
 arch/arm/boot/dts/imx6qp.dtsi                      | 10 +++++
 arch/arm/boot/dts/imx7d-pinfunc.h                  | 12 +++--
 arch/arm/mach-imx/common.h                         |  1 -
 arch/arm/mach-imx/imx31-dt.c                       |  6 ---
 drivers/clk/imx/clk-imx31.c                        | 52 +++++++++++-----------
 8 files changed, 52 insertions(+), 46 deletions(-)
