From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 6 Jun 2017 20:50:41 +0300
Subject: [PATCH v2 0/2] ARM: imx6ull: Make suspend/resume work like on 6ul
Message-ID: <cover.1496771145.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and resume on imx6ull is currenty not working because of some
missed checks where behavior should match imx6ul.

Looking at the reference manual I don't think BM_CLPCR_BYP_MMDC_CH0_LPM_HS
needs to be set, it's just that BM_CLPCR_BYP_MMDC_CH1_LPM_HS should not be set
like on imx6qdl. But this would be an unrelated cleanup and affect other chips
as well (everything other that imx6qdl).

Changes since v1 https://lkml.org/lkml/2017/5/30/584 :
 * Split adding MXC_CPU_IMX6ULL into a separate patch
 * While we're at it fix soc_id reading "Unknown"

Leonard Crestez (2):
  ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull
  ARM: imx6ull: Make suspend/resume work like on 6ul

 arch/arm/mach-imx/cpu.c     | 3 +++
 arch/arm/mach-imx/mxc.h     | 6 ++++++
 arch/arm/mach-imx/pm-imx6.c | 6 ++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.7.4
