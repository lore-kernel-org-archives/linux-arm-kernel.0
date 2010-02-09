From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon,  8 Feb 2010 16:11:33 -0800
Subject: [PATCH 12/14] AMBA: CLCD: LPC32XX register swap in the clcd header
	file
In-Reply-To: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1265674295-23996-13-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The CTRL and IENB registers need to be swapped for the LPC32XX
arch.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 include/linux/amba/clcd.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index 29c0448..8d0d491 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -21,7 +21,8 @@
 #define CLCD_UBAS 		0x00000010
 #define CLCD_LBAS 		0x00000014
 
-#if !defined(CONFIG_ARCH_VERSATILE) && !defined(CONFIG_ARCH_REALVIEW)
+#if !defined(CONFIG_ARCH_VERSATILE) && !defined(CONFIG_ARCH_REALVIEW)\
+	&& !defined(CONFIG_ARCH_LPC32XX)
 #define CLCD_IENB 		0x00000018
 #define CLCD_CNTL 		0x0000001c
 #else
-- 
1.6.6
