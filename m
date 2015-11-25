From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 23:03:49 +0100
Subject: [PATCH] clk: mmp: add linux/clk.h includes
Message-ID: <5338608.iS8N3pHg9B@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The common clk implementation for MMP broke without anyone noticing
when we stopped including linux/clk.h from the clk-provider header.

This did not show up in the defconfig builds because those use the
legacy MMP clk drivers, and it did not show up in my randconfig tests
either because I was testing with my mmp multiplatform series
applied, which at some point gained the fixup.

This fixes the three broken files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 61ae76563ec3 ("clk: Remove clk.h from clk-provider.h")

diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index 09d2832fbd78..71fd29348f28 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
diff --git a/drivers/clk/mmp/clk-pxa168.c b/drivers/clk/mmp/clk-pxa168.c
index 93e967c0f972..75244915df05 100644
--- a/drivers/clk/mmp/clk-pxa168.c
+++ b/drivers/clk/mmp/clk-pxa168.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 993abcdb32cc..37ba04ba1368 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
