From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 9 Aug 2016 16:24:43 +0800
Subject: [PATCH 1/1] ARM: mach-imx: pm-imx6: add missing
 BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul
Message-ID: <1470731083-26213-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a missing BM_CLPCR_BYP_MMDC_CH0_LPM_HS setting for imx6ul,
without it, the "standby" mode can't work well, the system can't be
resumed.

With this commit, the "standby" mode works well.

Cc: Anson Huang <anson.huang@nxp.com>
Cc: <stable@vger.kernel.org>
Fixes: ee4a5f838c84 ("ARM: imx: add suspend/resume support for i.mx6ul")
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/mach-imx/pm-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index 58924b3..67bab74 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -295,7 +295,7 @@ int imx6_set_lpm(enum mxc_cpu_pwr_mode mode)
 		val &= ~BM_CLPCR_SBYOS;
 		if (cpu_is_imx6sl())
 			val |= BM_CLPCR_BYPASS_PMIC_READY;
-		if (cpu_is_imx6sl() || cpu_is_imx6sx())
+		if (cpu_is_imx6sl() || cpu_is_imx6sx() || cpu_is_imx6ul())
 			val |= BM_CLPCR_BYP_MMDC_CH0_LPM_HS;
 		else
 			val |= BM_CLPCR_BYP_MMDC_CH1_LPM_HS;
-- 
1.9.1
