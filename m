From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 31 Mar 2011 10:53:55 +0200
Subject: [PATCH 6/9] mach-ux500: update ASIC version detection
Message-ID: <1301561635-23748-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This makes the core detect the DB8500 V2.0 and V2.1 ASICs, and
add a convenience macro for "V2 or later".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/id.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index f1288d1..02b541a 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -75,6 +75,26 @@ static inline bool __attribute_const__ cpu_is_u8500v2(void)
 	return cpu_is_u8500() && ((dbx500_revision() & 0xf0) == 0xB0);
 }
 
+static inline bool cpu_is_u8500v20(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() == 0xB0);
+}
+
+static inline bool cpu_is_u8500v21(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() == 0xB1);
+}
+
+static inline bool cpu_is_u8500v20_or_later(void)
+{
+	return cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11();
+}
+
+static inline bool ux500_is_svp(void)
+{
+	return false;
+}
+
 #define ux500_unknown_soc()	BUG()
 
 #endif
-- 
1.7.3.2
