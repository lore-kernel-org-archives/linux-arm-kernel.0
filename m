From: mkarthi3@visteon.com (Mutharaju, Prasanna (P.))
Date: Mon, 5 Oct 2015 11:45:08 +0000
Subject: [PATCH] soc: Fix for clean up pmic driver - trivial
Message-ID: <20151005114444.GA11494@jci-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prasanna Karthik <mkarthi3@visteon.com>

Prefer using the BIT macro reported by checkpatch

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index f432291..628a919 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -35,8 +35,8 @@
 #define PWRAP_GET_WACS_RDATA(x)		(((x) >> 0) & 0x0000ffff)
 #define PWRAP_GET_WACS_FSM(x)		(((x) >> 16) & 0x00000007)
 #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) & 0x00000001)
-#define PWRAP_STATE_SYNC_IDLE0		(1 << 20)
-#define PWRAP_STATE_INIT_DONE0		(1 << 21)
+#define PWRAP_STATE_SYNC_IDLE0		BIT(20)
+#define PWRAP_STATE_INIT_DONE0		BIT(21)
 
 /* macro for WACS FSM */
 #define PWRAP_WACS_FSM_IDLE		0x00
@@ -52,7 +52,7 @@
 #define PWRAP_DEW_WRITE_TEST_VAL	0xa55a
 
 /* macro for manual command */
-#define PWRAP_MAN_CMD_SPI_WRITE		(1 << 13)
+#define PWRAP_MAN_CMD_SPI_WRITE		BIT(13)
 #define PWRAP_MAN_CMD_OP_CSH		(0x0 << 8)
 #define PWRAP_MAN_CMD_OP_CSL		(0x1 << 8)
 #define PWRAP_MAN_CMD_OP_CK		(0x2 << 8)
-- 
1.9.1
