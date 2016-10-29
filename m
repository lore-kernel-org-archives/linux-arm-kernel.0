From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 29 Oct 2016 13:56:30 +0200
Subject: [PATCH v2] ARM: pxa: remove duplicated include from spitz.c
Message-ID: <1477742190-3300-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyj.lk@gmail.com>

This partially reverts commit 12beb346710b ("Merge tag 'pxa-fixes-v4.8'
of https://github.com/rjarzmik/linux into randconfig-4.8").

This former patch introduced accidentally a double include of module.h.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>
[amended commit message and 2 comments]
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/corgi.c | 1 -
 arch/arm/mach-pxa/spitz.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 10bfdb169366..183cd3446f25 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -35,7 +35,6 @@
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
-#include <linux/module.h>
 #include <linux/memblock.h>
 #include <video/w100fb.h>
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 2c150bfc0cd5..67d66c702574 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -31,7 +31,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
-#include <linux/module.h>
 #include <linux/reboot.h>
 #include <linux/memblock.h>
 
-- 
2.1.4
