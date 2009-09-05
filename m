From: jsgood.yang@samsung.com (=?UTF-8?B?7JaR7KeE7ISx?=)
Date: Sat, 05 Sep 2009 22:30:14 +0900
Subject: [PATCH 07/12] [ARM][S3C6410] Add definition of keypad platform data
Message-ID: <00a901ca2e2d$004e7bf0$00eb73d0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch includes platform data header of keypad driver and
extern definition of function to set platform data.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/plat-s3c/include/plat/keypad.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/include/plat/keypad.h

diff --git a/arch/arm/plat-s3c/include/plat/keypad.h b/arch/arm/plat-s3c/include/plat/keypad.h
new file mode 100644
index 0000000..caf2417
--- /dev/null
+++ b/arch/arm/plat-s3c/include/plat/keypad.h
@@ -0,0 +1,14 @@
+#ifndef __ASM_PLAT_S3C_KEYPAD_H
+#define __ASM_PLAT_S3C_KEYPAD_H
+
+struct s3c_platform_keypad {
+	int nr_rows;
+	int nr_cols;
+	int max_keys;
+	int max_masks;
+	int delay;
+};
+
+extern void s3c_keypad_set_platdata(struct s3c_platform_keypad *pd);
+
+#endif /* __ASM_PLAT_S3C_KEYPAD_H */
-- 
1.6.2.5
