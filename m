From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 26 May 2014 06:50:32 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v3.16
Message-ID: <392166a3-2314-442d-86e3-91a1d01fed7e@BN1AFFO11FD041.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

please pull these changes to your arm-soc tree.
Based on my discussion with Arnd regarding SOC-BUS here
"http://www.spinics.net/lists/arm-kernel/msg325629.html"
I have also added this patch.

Thanks,
Michal


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.16

for you to fetch changes up to eb28d0bb857f01ff972f8b359c962eef9ecf1b64:

  ARM: zynq: Enable big-endian (2014-05-20 16:17:13 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.16

- Add support for BIG Endian
- Add SOC_BUS support
- Sort Kconfig options
- Fix early console

----------------------------------------------------------------
Michal Simek (5):
      ARM: zynq: Add support for SOC_BUS
      ARM: zynq: Sort Kconfig options
      clocksource: cadence_ttc: Use readl/writel_relaxed instead of __raw
      ARM: zynq: Fix uart0 early console virtual address
      ARM: zynq: Enable big-endian

 arch/arm/boot/dts/zynq-7000.dtsi        |  5 +++++
 arch/arm/include/debug/zynq.S           | 10 ++++++----
 arch/arm/mach-zynq/Kconfig              | 10 ++++++----
 arch/arm/mach-zynq/common.c             | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-zynq/common.h             |  1 +
 arch/arm/mach-zynq/headsmp.S            |  5 ++++-
 arch/arm/mach-zynq/slcr.c               | 19 +++++++++++++++++++
 drivers/clocksource/cadence_ttc_timer.c | 54 +++++++++++++++++++++++++++---------------------------
 8 files changed, 138 insertions(+), 37 deletions(-)
