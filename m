From: robh@kernel.org (Rob Herring)
Date: Thu,  1 Mar 2018 09:25:15 -0600
Subject: [PATCH] ARM: boot: add strrchr function
Message-ID: <20180301152515.27004-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

libfdt gained a new dependency on strrchr, so copy the implementation
from lib/string.c.

Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack. This is a dependency for dtc/libfdt sync with upstream.

 arch/arm/boot/compressed/string.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/compressed/string.c b/arch/arm/boot/compressed/string.c
index 13c90abc68d6..ade5079bebbf 100644
--- a/arch/arm/boot/compressed/string.c
+++ b/arch/arm/boot/compressed/string.c
@@ -121,6 +121,16 @@ char *strchr(const char *s, int c)
 	return (char *)s;
 }
 
+char *strrchr(const char *s, int c)
+{
+	const char *last = NULL;
+	do {
+		if (*s == (char)c)
+			last = s;
+	} while (*s++);
+	return (char *)last;
+}
+
 #undef memset
 
 void *memset(void *s, int c, size_t count)
-- 
2.14.1
