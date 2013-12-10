From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 15:35:16 -0800
Subject: [PATCH 1/8] mfd: ssbi: Remove platform data structs and hide ssbi
 type enum
In-Reply-To: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1386718523-2587-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ssbi driver assumes that the device is DT based. Remove the
platform data structs that will never be used and hide the enum
in the only C file that uses it.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/mfd/ssbi.c   |  6 ++++++
 include/linux/ssbi.h | 17 +----------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/ssbi.c b/drivers/mfd/ssbi.c
index 102a2284..435c6f7 100644
--- a/drivers/mfd/ssbi.c
+++ b/drivers/mfd/ssbi.c
@@ -65,6 +65,12 @@
 
 #define SSBI_TIMEOUT_US			100
 
+enum ssbi_controller_type {
+	MSM_SBI_CTRL_SSBI = 0,
+	MSM_SBI_CTRL_SSBI2,
+	MSM_SBI_CTRL_PMIC_ARBITER,
+};
+
 struct ssbi {
 	struct device		*slave;
 	void __iomem		*base;
diff --git a/include/linux/ssbi.h b/include/linux/ssbi.h
index 44ef5da..a92561a 100644
--- a/include/linux/ssbi.h
+++ b/include/linux/ssbi.h
@@ -17,22 +17,7 @@
 
 #include <linux/types.h>
 
-struct ssbi_slave_info {
-	const char	*name;
-	void		*platform_data;
-};
-
-enum ssbi_controller_type {
-	MSM_SBI_CTRL_SSBI = 0,
-	MSM_SBI_CTRL_SSBI2,
-	MSM_SBI_CTRL_PMIC_ARBITER,
-};
-
-struct ssbi_platform_data {
-	struct ssbi_slave_info	slave;
-	enum ssbi_controller_type controller_type;
-};
-
 int ssbi_write(struct device *dev, u16 addr, u8 *buf, int len);
 int ssbi_read(struct device *dev, u16 addr, u8 *buf, int len);
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
