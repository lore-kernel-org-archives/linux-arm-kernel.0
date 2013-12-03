From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 3 Dec 2013 15:33:55 -0600
Subject: [GIT PULL] socfpga fix for 3.13
Message-ID: <1386106435-25013-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b5afaa4672cc0f3d707ffa56c6b392646c323a8d:

  Linux 3.13-rc1 (2013-12-03 15:00:46 -0600)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-kconfig-fixes-for-3.13

for you to fetch changes up to 2f9f487fb54b4fa9c456921037fb508f5dd7e39b:

  arm: dts: socfpga: Change some clocks of gate-clk type to perip-clk (2013-12-03 15:03:19 -0600)

----------------------------------------------------------------
Because of commit :

[159c7f8 arm: socfpga: Add clock for smp_twd timer],

where the "arm,cortex-a9-twd-timer" is assigned the mpu_periph_clk, the twd
timer driver will grab and enable that clock. However, since the mpu_periph_clk
does not have a gate, the generic call to enable the clock will fail.

Commit : [2f9f487f arm: dts: socfpga: Change some clocks of gate-clk type to perip-clk] will fix this issue.

The 2nd commit : [73fa7bb arm: socfpga: Enable ARM_TWD for socfpga] enables the
ARM_TWD timer]

----------------------------------------------------------------
Dinh Nguyen (2):
      arm: socfpga: Enable ARM_TWD for socfpga
      arm: dts: socfpga: Change some clocks of gate-clk type to perip-clk

 arch/arm/boot/dts/socfpga.dtsi |    7 ++++---
 arch/arm/mach-socfpga/Kconfig  |    1 +
 2 files changed, 5 insertions(+), 3 deletions(-)
