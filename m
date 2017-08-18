From: ryder.lee@mediatek.com (Ryder Lee)
Date: Fri, 18 Aug 2017 11:48:05 +0800
Subject: [PATCH] pinctrl: mediatek: update PCIe mux data for MT7623
Message-ID: <ddbc91742005abfc9083876fb976ecc511be98fd.1503026874.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2701 shares the same driver with MT7623, but there is a slight difference
between their pin functions (e.g., PCIe), so we update the different parts
in pinmux table.

Doing so, SoC could choose the correct mux setting via their own pinfun.h.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
CC: Biao Huang <biao.huang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
index f906420..1035df4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
@@ -223,6 +223,8 @@
 		MTK_EINT_FUNCTION(0, 0),
 		MTK_FUNCTION(0, "GPIO22"),
 		MTK_FUNCTION(1, "UCTS0"),
+		/* MT7623 take function 2 as PCIE0_PERST_N */
+		MTK_FUNCTION(2, "PCIE0_PERST_N"),
 		MTK_FUNCTION(3, "KCOL3"),
 		MTK_FUNCTION(4, "CONN_DSP_JDO"),
 		MTK_FUNCTION(5, "EXT_FRAME_SYNC"),
@@ -235,6 +237,8 @@
 		MTK_EINT_FUNCTION(0, 1),
 		MTK_FUNCTION(0, "GPIO23"),
 		MTK_FUNCTION(1, "URTS0"),
+		/* MT7623 take function 2 as PCIE1_PERST_N */
+		MTK_FUNCTION(2, "PCIE1_PERST_N"),
 		MTK_FUNCTION(3, "KCOL2"),
 		MTK_FUNCTION(4, "CONN_MCU_TDO"),
 		MTK_FUNCTION(5, "EXT_FRAME_SYNC"),
@@ -247,6 +251,8 @@
 		MTK_EINT_FUNCTION(0, 2),
 		MTK_FUNCTION(0, "GPIO24"),
 		MTK_FUNCTION(1, "UCTS1"),
+		/* MT7623 take function 2 as PCIE2_PERST_N */
+		MTK_FUNCTION(2, "PCIE2_PERST_N"),
 		MTK_FUNCTION(3, "KCOL1"),
 		MTK_FUNCTION(4, "CONN_MCU_DBGACK_N"),
 		MTK_FUNCTION(7, "DBG_MON_A[28]"),
@@ -308,6 +314,8 @@
 		MTK_FUNCTION(3, "KROW0"),
 		MTK_FUNCTION(4, "CONN_MCU_TMS"),
 		MTK_FUNCTION(5, "CONN_MCU_AICE_JMSC"),
+		/* MT7623 take function 6 as PCIE2_PERST_N */
+		MTK_FUNCTION(6, "PCIE2_PERST_N"),
 		MTK_FUNCTION(7, "DBG_MON_A[23]"),
 		MTK_FUNCTION(14, "PCIE2_PERST_N")
 	),
@@ -1787,6 +1795,8 @@
 		MTK_FUNCTION(0, "GPIO208"),
 		MTK_FUNCTION(1, "AUD_EXT_CK1"),
 		MTK_FUNCTION(2, "PWM0"),
+		/* MT7623 take function 3 as PCIE0_PERST_N */
+		MTK_FUNCTION(3, "PCIE0_PERST_N"),
 		MTK_FUNCTION(4, "ANT_SEL5"),
 		MTK_FUNCTION(5, "DISP_PWM"),
 		MTK_FUNCTION(7, "DBG_MON_A[31]"),
@@ -1799,6 +1809,8 @@
 		MTK_FUNCTION(0, "GPIO209"),
 		MTK_FUNCTION(1, "AUD_EXT_CK2"),
 		MTK_FUNCTION(2, "MSDC1_WP"),
+		/* MT7623 take function 3 as PCIE1_PERST_N */
+		MTK_FUNCTION(3, "PCIE1_PERST_N"),
 		MTK_FUNCTION(5, "PWM1"),
 		MTK_FUNCTION(7, "DBG_MON_A[32]"),
 		MTK_FUNCTION(11, "PCIE1_PERST_N")
-- 
1.9.1
