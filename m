From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Thu, 27 Mar 2014 16:37:44 +0530
Subject: [PATCH v2 1/7] clk: exynos5420: Add more clock register offsets
In-Reply-To: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
References: <1395918470-16374-1-git-send-email-shaik.ameer@samsung.com>
Message-ID: <1395918470-16374-2-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <rahul.sharma@samsung.com>

This patch adds the missing clock register offsets for Exynos5420.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c |   29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 13f624d..3d0fb77 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -27,6 +27,9 @@
 #define DIV_CPU1		0x504
 #define GATE_BUS_CPU		0x700
 #define GATE_SCLK_CPU		0x800
+#define CLKOUT_CMU_CPU		0xa00
+#define DIV_G2D			0x8500
+#define GATE_BUS_G2D		0x8700
 #define GATE_IP_G2D		0x8800
 #define CPLL_LOCK		0x10020
 #define DPLL_LOCK		0x10030
@@ -39,7 +42,11 @@
 #define CPLL_CON0		0x10120
 #define DPLL_CON0		0x10128
 #define EPLL_CON0		0x10130
+#define EPLL_CON1		0x10134
+#define EPLL_CON2		0x10138
 #define RPLL_CON0		0x10140
+#define RPLL_CON1		0x10144
+#define RPLL_CON2		0x10148
 #define IPLL_CON0		0x10150
 #define SPLL_CON0		0x10160
 #define VPLL_CON0		0x10170
@@ -57,10 +64,13 @@
 #define SRC_FSYS		0x10244
 #define SRC_PERIC0		0x10250
 #define SRC_PERIC1		0x10254
+#define SRC_ISP			0x10270
 #define SRC_TOP10		0x10280
 #define SRC_TOP11		0x10284
 #define SRC_TOP12		0x10288
-#define	SRC_MASK_DISP10		0x1032c
+#define SRC_MASK_TOP2		0x10308
+#define SRC_MASK_DISP10		0x1032c
+#define SRC_MASK_MAU		0x10334
 #define SRC_MASK_FSYS		0x10340
 #define SRC_MASK_PERIC0		0x10350
 #define SRC_MASK_PERIC1		0x10354
@@ -77,24 +87,41 @@
 #define DIV_PERIC2		0x10560
 #define DIV_PERIC3		0x10564
 #define DIV_PERIC4		0x10568
+#define SCLK_DIV_ISP0		0x10580
+#define SCLK_DIV_ISP1		0x10584
+#define DIV2_RATIO0		0x10590
+#define DIV4_RATIO		0x105a0
 #define GATE_BUS_TOP		0x10700
+#define GATE_BUS_GSCL0		0x10710
+#define GATE_BUS_GSCL1		0x10720
+#define GATE_BUS_DISP1		0x10728
+#define GATE_BUS_MFC		0x10734
+#define GATE_BUS_GEN		0x1073c
 #define GATE_BUS_FSYS0		0x10740
+#define GATE_BUS_FSYS2		0x10748
+#define GATE_BUS_MSCL		0x1074C
 #define GATE_BUS_PERIC		0x10750
 #define GATE_BUS_PERIC1		0x10754
 #define GATE_BUS_PERIS0		0x10760
 #define GATE_BUS_PERIS1		0x10764
+#define GATE_BUS_NOC		0x10770
+#define GATE_TOP_SCLK_ISP	0x10870
 #define GATE_IP_GSCL0		0x10910
 #define GATE_IP_GSCL1		0x10920
 #define GATE_IP_MFC		0x1092c
 #define GATE_IP_DISP1		0x10928
 #define GATE_IP_G3D		0x10930
 #define GATE_IP_GEN		0x10934
+#define GATE_IP_FSYS		0x10944
+#define GATE_IP_PERIC		0x10950
+#define GATE_IP_PERIS		0x10960
 #define GATE_IP_MSCL		0x10970
 #define GATE_TOP_SCLK_GSCL	0x10820
 #define GATE_TOP_SCLK_DISP1	0x10828
 #define GATE_TOP_SCLK_MAU	0x1083c
 #define GATE_TOP_SCLK_FSYS	0x10840
 #define GATE_TOP_SCLK_PERIC	0x10850
+#define TOP_SPARE2		0x10b08
 #define BPLL_LOCK		0x20010
 #define BPLL_CON0		0x20110
 #define SRC_CDREX		0x20200
-- 
1.7.9.5
