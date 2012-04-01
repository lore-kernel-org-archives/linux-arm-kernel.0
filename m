From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun,  1 Apr 2012 18:30:41 +0300
Subject: [PATCH] omap1: mux: add missing include
Message-ID: <1333294241-17510-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build breakage in v3.4-rc1:

arch/arm/mach-omap1/mux.c:89:1: error: 'FUNC_MUX_CTRL_9' undeclared here (not in a function)
arch/arm/mach-omap1/mux.c:89:1: error: 'PULL_DWN_CTRL_2' undeclared here (not in a function)
arch/arm/mach-omap1/mux.c:93:1: error: 'FUNC_MUX_CTRL_C' undeclared here (not in a function)

etc.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/mux.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 087dba0..e9cc52d 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 
+#include <mach/hardware.h>
 
 #include <plat/mux.h>
 
-- 
1.7.2.5
