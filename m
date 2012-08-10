From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 10 Aug 2012 10:44:14 +0200
Subject: [PATCH 4/4] ARM: ux500: add detection for DB8500 ASIC v2.2
Message-ID: <1344588254-8706-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Add a macro to properly detect the v2.2 version of the
DB8500 ASIC.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/include/mach/id.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-ux500/include/mach/id.h b/arch/arm/mach-ux500/include/mach/id.h
index c7fcf69..9c42642 100644
--- a/arch/arm/mach-ux500/include/mach/id.h
+++ b/arch/arm/mach-ux500/include/mach/id.h
@@ -105,6 +105,11 @@ static inline bool cpu_is_u8500v21(void)
 	return cpu_is_u8500() && (dbx500_revision() == 0xB1);
 }
 
+static inline bool cpu_is_u8500v22(void)
+{
+	return cpu_is_u8500() && (dbx500_revision() == 0xB2);
+}
+
 static inline bool cpu_is_u8500v20_or_later(void)
 {
 	return (cpu_is_u8500() && !cpu_is_u8500v10() && !cpu_is_u8500v11());
-- 
1.7.11.3
