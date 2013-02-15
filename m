From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Feb 2013 12:44:31 +0000
Subject: [PATCH 01/40] mfd: Differentiate between newly added abx500 based
 platforms
In-Reply-To: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
References: <1360932310-30065-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1360932310-30065-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the functionality to check for more abx500 type platforms.
These new platforms include: ab9540v3, <=ab8540v1, <=ab8540v1.1,
<=ab8540v1.2, <=ab8540v2, ab8540v2, <=ab8505v2 and <=ab9540v2.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/abx500/ab8500.h |   46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index b9a6a84..28bffd0 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -32,6 +32,7 @@ enum ab8500_version {
 #define AB8500_CUTEARLY	0x00
 #define AB8500_CUT1P0	0x10
 #define AB8500_CUT1P1	0x11
+#define AB8500_CUT1P2	0x12 /* Only valid for AB8540 */
 #define AB8500_CUT2P0	0x20
 #define AB8500_CUT3P0	0x30
 #define AB8500_CUT3P3	0x33
@@ -365,4 +366,49 @@ static inline int is_ab9540_2p0(struct ab8500 *ab)
 {
 	return (is_ab9540(ab) && (ab->chip_id == AB8500_CUT2P0));
 }
+
+/*
+ * Be careful, the marketing name for this chip is 2.1
+ * but the value read from the chip is 3.0 (0x30)
+ */
+static inline int is_ab9540_3p0(struct ab8500 *ab)
+{
+	return (is_ab9540(ab) && (ab->chip_id == AB8500_CUT3P0));
+}
+
+static inline int is_ab8540_1p0_or_earlier(struct ab8500 *ab)
+{
+	return is_ab8540(ab) && (ab->chip_id <= AB8500_CUT1P0);
+}
+
+static inline int is_ab8540_1p1_or_earlier(struct ab8500 *ab)
+{
+	return is_ab8540(ab) && (ab->chip_id <= AB8500_CUT1P1);
+}
+
+static inline int is_ab8540_1p2_or_earlier(struct ab8500 *ab)
+{
+	return is_ab8540(ab) && (ab->chip_id <= AB8500_CUT1P2);
+}
+
+static inline int is_ab8540_2p0_or_earlier(struct ab8500 *ab)
+{
+	return is_ab8540(ab) && (ab->chip_id <= AB8500_CUT2P0);
+}
+
+static inline int is_ab8540_2p0(struct ab8500 *ab)
+{
+	return is_ab8540(ab) && (ab->chip_id == AB8500_CUT2P0);
+}
+
+static inline int is_ab8505_2p0_earlier(struct ab8500 *ab)
+{
+	return (is_ab8505(ab) && (ab->chip_id < AB8500_CUT2P0));
+}
+
+static inline int is_ab9540_2p0_or_earlier(struct ab8500 *ab)
+{
+	return (is_ab9540(ab) && (ab->chip_id < AB8500_CUT2P0));
+}
+
 #endif /* MFD_AB8500_H */
-- 
1.7.10.4
