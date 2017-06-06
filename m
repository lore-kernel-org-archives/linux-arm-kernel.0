From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 6 Jun 2017 20:50:43 +0300
Subject: [PATCH v2 2/2] ARM: imx6ull: Make suspend/resume work like on 6ul
In-Reply-To: <cover.1496771145.git.leonard.crestez@nxp.com>
References: <cover.1496771145.git.leonard.crestez@nxp.com>
Message-ID: <7dcc71ab09d8d459de1826e55516349b1a2bda33.1496771145.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and resume on imx6ull is currenty not working because of some
missed checks where behavior should match imx6ul.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index e61b1d1..ecdf071 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -295,7 +295,8 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val &= ~BM_CLPCR_SBYOS;
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
+		    cpu_is_imx6ull())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
@@ -312,7 +313,8 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val |= BM_CLPCR_SBYOS;
 		if (cpu_is_imx6sl() || cpu_is_imx6sx())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul() ||
+		    cpu_is_imx6ull())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
2.7.4
