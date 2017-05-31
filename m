From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 31 May 2017 13:58:43 +0300
Subject: [PATCH 01/10] staging: fsl-mc: enclose macro params in parens
In-Reply-To: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
Message-ID: <20170531105852.22304-2-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Several macros didn't had macro params enclosed
in parens. Fix them to avoid precedence issues.

Found with checkpatch.pl who was issuing this
message:
  "Macro argument 'id' may be better as '(id)'
   to avoid precedence issues"

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpbp-cmd.h  | 2 +-
 drivers/staging/fsl-mc/bus/dpmcp-cmd.h | 2 +-
 drivers/staging/fsl-mc/bus/dpmng-cmd.h | 2 +-
 drivers/staging/fsl-mc/bus/dprc-cmd.h  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
index 8aa6545..5904836 100644
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
@@ -40,7 +40,7 @@
 #define DPBP_CMD_BASE_VERSION			1
 #define DPBP_CMD_ID_OFFSET			4
 
-#define DPBP_CMD(id)	((id << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
+#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
diff --git a/drivers/staging/fsl-mc/bus/dpmcp-cmd.h b/drivers/staging/fsl-mc/bus/dpmcp-cmd.h
index 384a13d..861b2a7 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpmcp-cmd.h
@@ -40,7 +40,7 @@
 #define DPMCP_CMD_BASE_VERSION		1
 #define DPMCP_CMD_ID_OFFSET		4
 
-#define DPMCP_CMD(id)	((id << DPMCP_CMD_ID_OFFSET) | DPMCP_CMD_BASE_VERSION)
+#define DPMCP_CMD(id)	(((id) << DPMCP_CMD_ID_OFFSET) | DPMCP_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPMCP_CMDID_CLOSE		DPMCP_CMD(0x800)
diff --git a/drivers/staging/fsl-mc/bus/dpmng-cmd.h b/drivers/staging/fsl-mc/bus/dpmng-cmd.h
index cdddfb8..d1f04ac 100644
--- a/drivers/staging/fsl-mc/bus/dpmng-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpmng-cmd.h
@@ -44,7 +44,7 @@
 #define DPMNG_CMD_BASE_VERSION		1
 #define DPMNG_CMD_ID_OFFSET		4
 
-#define DPMNG_CMD(id)	((id << DPMNG_CMD_ID_OFFSET) | DPMNG_CMD_BASE_VERSION)
+#define DPMNG_CMD(id)	(((id) << DPMNG_CMD_ID_OFFSET) | DPMNG_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPMNG_CMDID_GET_VERSION		DPMNG_CMD(0x831)
diff --git a/drivers/staging/fsl-mc/bus/dprc-cmd.h b/drivers/staging/fsl-mc/bus/dprc-cmd.h
index e9fdca4..d9b2dcd 100644
--- a/drivers/staging/fsl-mc/bus/dprc-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dprc-cmd.h
@@ -48,7 +48,7 @@
 #define DPRC_CMD_BASE_VERSION			1
 #define DPRC_CMD_ID_OFFSET			4
 
-#define DPRC_CMD(id)	((id << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
+#define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
 
 /* Command IDs */
 #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
-- 
2.9.4
