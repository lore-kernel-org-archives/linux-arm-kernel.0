From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue,  6 Feb 2018 15:26:26 +0100
Subject: [PATCHv2 0/3] Improved perf support for imx53/ppd
Message-ID: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This improves perf on imx53 by adding support for enabling the Secure
Debug Enable Register (SDER) SUNIDEN bit. This unlocks new
functionality:

ppd before patchset# perf stat -e cycles,instructions sleep 1 2>&1 | grep instructions
                 0      instructions              #    0.00  insn per cycle

ppd  after patchset# perf stat -e cycles,instructions sleep 1 2>&1 | grep instructions
            177864      instructions              #    0.05  insn per cycle

Changes since PATCHv1:
 * Update DTS patch to reference imx53.dtsi's pmu node
 * Remove a superfluous newline in first patch

-- Sebastian

Peter Senna Tschudin (2):
  ARM: imx53: add SoC specific PMU setup
  ARM: dts: imx53: PPD: Enable secure-reg-access

Sebastian Reichel (1):
  drivers/perf: arm_pmu: Add platform hardware setup hooks.

 arch/arm/boot/dts/imx53-ppd.dts |  4 +++
 arch/arm/boot/dts/imx53.dtsi    |  2 +-
 arch/arm/mach-imx/mach-imx53.c  | 68 +++++++++++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c          | 12 ++++++++
 include/linux/perf/arm_pmu.h    |  5 +++
 5 files changed, 90 insertions(+), 1 deletion(-)

-- 
2.15.1
