From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 18 Jan 2018 18:43:42 +0100
Subject: [PATCH 0/3] Improved perf support for imx53/ppd
Message-ID: <20180118174345.26620-1-sebastian.reichel@collabora.co.uk>
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

-- Sebastian

Peter Senna Tschudin (2):
  ARM: imx53: add SoC specific PMU setup
  ARM: dts: imx53: PPD: Enable secure-reg-access

Sebastian Reichel (1):
  drivers/perf: arm_pmu: Add platform hardware setup hooks.

 arch/arm/boot/dts/imx53-ppd.dts |  6 ++++
 arch/arm/mach-imx/mach-imx53.c  | 68 +++++++++++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c          | 13 ++++++++
 include/linux/perf/arm_pmu.h    |  5 +++
 4 files changed, 92 insertions(+)

-- 
2.15.1
