From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 30 Sep 2011 16:41:36 +0530
Subject: [PATCH 1/2] ARM: CLKDEV: Add Common Macro for clk_lookup
In-Reply-To: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
Message-ID: <1317381097-2691-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a standardized macro CLKDEV_INIT which can used across all
the platforms to support clkdev

Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 include/linux/clkdev.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 457bcb0..f2db158 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -14,6 +14,13 @@
 
 #include <asm/clkdev.h>
 
+#define CLKDEV_INIT(d, n, c) \
+	{ \
+		.dev_id = d, \
+		.con_id = n, \
+		.clk = &c, \
+	},
+
 struct clk;
 struct device;
 
-- 
1.7.4.4
