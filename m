From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:55 +0000
Subject: [PATCH] ARM: S3C64XX: Move GPIO bank number includes into machine
	include directory
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the GPIO bank numbering to the machine include directory as it is only
used by these machines. Fixup the two users in the plat directoy (but do not
move them yet)

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 .../include/mach}/gpio-bank-a.h                    |    2 +-
 .../include/mach}/gpio-bank-b.h                    |    2 +-
 .../include/mach}/gpio-bank-c.h                    |    2 +-
 .../include/mach}/gpio-bank-d.h                    |    2 +-
 .../include/mach}/gpio-bank-e.h                    |    2 +-
 .../include/mach}/gpio-bank-f.h                    |    2 +-
 .../include/mach}/gpio-bank-g.h                    |    2 +-
 .../include/mach}/gpio-bank-h.h                    |    2 +-
 .../include/mach}/gpio-bank-i.h                    |    2 +-
 .../include/mach}/gpio-bank-j.h                    |    2 +-
 .../include/mach}/gpio-bank-n.h                    |    2 +-
 .../include/mach}/gpio-bank-o.h                    |    2 +-
 .../include/mach}/gpio-bank-p.h                    |    2 +-
 .../include/mach}/gpio-bank-q.h                    |    2 +-
 arch/arm/plat-s3c64xx/dev-audio.c                  |    9 +++++----
 arch/arm/plat-s3c64xx/dev-spi.c                    |    3 +--
 arch/arm/plat-s3c64xx/pm.c                         |    2 +-
 arch/arm/plat-s3c64xx/setup-i2c0.c                 |    2 +-
 arch/arm/plat-s3c64xx/setup-i2c1.c                 |    2 +-
 19 files changed, 23 insertions(+), 23 deletions(-)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-a.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-b.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-c.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-d.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-e.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-f.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-g.h (95%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-h.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-i.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-j.h (95%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-n.h (96%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-o.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-p.h (97%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/gpio-bank-q.h (96%)

diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-a.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
similarity index 96%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-a.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
index 9aa0e42..34212e1 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-a.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-a.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-b.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
similarity index 97%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-b.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
index 3933adb..7232c03 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-b.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-b.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
similarity index 96%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
index e22b49f..db189ab 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-c.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-d.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
similarity index 96%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-d.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
index 6fe4a49..1a01cee 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-d.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-d.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-e.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
similarity index 96%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-e.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
index 7fcf3d8..f057adb 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-e.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-e.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-f.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
similarity index 97%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-f.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
index f3faff9..62ab8f5 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-f.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-f.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-g.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
similarity index 95%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-g.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
index 35bbd23..b94954a 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-g.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-g.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-h.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
similarity index 97%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-h.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
index 2ba1767..5d75aaa 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-h.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-h.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-i.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
similarity index 96%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-i.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
index ce9ebe3..4ceaa60 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-i.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-i.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-j.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
similarity index 95%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-j.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
index 21a9062..6f25cd0 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-j.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-j.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-n.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
similarity index 96%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-n.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
index 569e761..d0aeda1 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-n.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-n.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-o.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
similarity index 97%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-o.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
index b09e129..21868fa 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-o.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-o.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-p.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
similarity index 97%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-p.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
index 92f0051..46bcfb6 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-p.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-p.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-q.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
similarity index 96%
rename from arch/arm/plat-s3c64xx/include/plat/gpio-bank-q.h
rename to arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
index 565e60a..1712223 100644
--- a/arch/arm/plat-s3c64xx/include/plat/gpio-bank-q.h
+++ b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c64xx/include/plat/gpio-bank-q.h
+/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
index f6b7bfb..aaffb80 100644
--- a/arch/arm/plat-s3c64xx/dev-audio.c
+++ b/arch/arm/plat-s3c64xx/dev-audio.c
@@ -19,12 +19,13 @@
 
 #include <plat/devs.h>
 #include <plat/audio.h>
-#include <plat/gpio-bank-c.h>
-#include <plat/gpio-bank-d.h>
-#include <plat/gpio-bank-e.h>
-#include <plat/gpio-bank-h.h>
 #include <plat/gpio-cfg.h>
 
+#include <mach/gpio-bank-c.h>
+#include <mach/gpio-bank-d.h>
+#include <mach/gpio-bank-e.h>
+#include <mach/gpio-bank-h.h>
+
 static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
diff --git a/arch/arm/plat-s3c64xx/dev-spi.c b/arch/arm/plat-s3c64xx/dev-spi.c
index ca10388..0c20d27 100644
--- a/arch/arm/plat-s3c64xx/dev-spi.c
+++ b/arch/arm/plat-s3c64xx/dev-spi.c
@@ -16,11 +16,10 @@
 #include <mach/dma.h>
 #include <mach/map.h>
 #include <mach/gpio.h>
+#include <mach/gpio-bank-c.h>
 
 #include <plat/spi-clocks.h>
-
 #include <plat/s3c64xx-spi.h>
-#include <plat/gpio-bank-c.h>
 #include <plat/gpio-cfg.h>
 #include <plat/irqs.h>
 
diff --git a/arch/arm/plat-s3c64xx/pm.c b/arch/arm/plat-s3c64xx/pm.c
index 47632fc..8ad9ab1 100644
--- a/arch/arm/plat-s3c64xx/pm.c
+++ b/arch/arm/plat-s3c64xx/pm.c
@@ -27,7 +27,7 @@
 #include <plat/regs-gpio-memport.h>
 
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
-#include <plat/gpio-bank-n.h>
+#include <mach/gpio-bank-n.h>
 
 void s3c_pm_debug_smdkled(u32 set, u32 clear)
 {
diff --git a/arch/arm/plat-s3c64xx/setup-i2c0.c b/arch/arm/plat-s3c64xx/setup-i2c0.c
index 3644807..d1b11e6 100644
--- a/arch/arm/plat-s3c64xx/setup-i2c0.c
+++ b/arch/arm/plat-s3c64xx/setup-i2c0.c
@@ -18,8 +18,8 @@
 struct platform_device; /* don't need the contents */
 
 #include <mach/gpio.h>
+#include <mach/gpio-bank-b.h>
 #include <plat/iic.h>
-#include <plat/gpio-bank-b.h>
 #include <plat/gpio-cfg.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
diff --git a/arch/arm/plat-s3c64xx/setup-i2c1.c b/arch/arm/plat-s3c64xx/setup-i2c1.c
index bbe229b..2dce57d 100644
--- a/arch/arm/plat-s3c64xx/setup-i2c1.c
+++ b/arch/arm/plat-s3c64xx/setup-i2c1.c
@@ -18,8 +18,8 @@
 struct platform_device; /* don't need the contents */
 
 #include <mach/gpio.h>
+#include <mach/gpio-bank-b.h>
 #include <plat/iic.h>
-#include <plat/gpio-bank-b.h>
 #include <plat/gpio-cfg.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
-- 
1.6.0.4
