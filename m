From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 29 Jan 2010 09:02:16 +0000
Subject: [PATCH] ARM: SAMSUNG: Move the last build from plat-s3c to
	plat-samsung
In-Reply-To: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
References: <1264755741-16184-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264755741-16184-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the init.c and time.c files to plat-samsung from plat-s3c, thus
clearing the last files that are being built in here.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Makefile                 |    4 +---
 arch/arm/plat-samsung/Makefile             |    2 ++
 arch/arm/plat-samsung/dma.c                |    2 +-
 arch/arm/{plat-s3c => plat-samsung}/init.c |    0
 arch/arm/{plat-s3c => plat-samsung}/time.c |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/init.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/time.c (99%)

diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 2a3c4a4..867c9cf 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -6,10 +6,8 @@
 
 obj-y				:=
 obj-m				:=
-obj-n				:=
+obj-n				:= dummy.o
 obj-				:=
 
 # Core support for all Samsung SoCs
 
-obj-y				+= init.o
-obj-y				+= time.o
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index facc7e3..22c89d0 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -11,6 +11,8 @@ obj-				:=
 
 # Objects we always build independent of SoC choice
 
+obj-y				+= init.o
+obj-y				+= time.o
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 obj-y				+= gpio.o
diff --git a/arch/arm/plat-samsung/dma.c b/arch/arm/plat-samsung/dma.c
index a995850..f82c68d 100644
--- a/arch/arm/plat-samsung/dma.c
+++ b/arch/arm/plat-samsung/dma.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c/dma.c
+/* linux/arch/arm/plat-samsung/dma.c
  *
  * Copyright (c) 2003-2009 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c/init.c b/arch/arm/plat-samsung/init.c
similarity index 100%
rename from arch/arm/plat-s3c/init.c
rename to arch/arm/plat-samsung/init.c
diff --git a/arch/arm/plat-s3c/time.c b/arch/arm/plat-samsung/time.c
similarity index 99%
rename from arch/arm/plat-s3c/time.c
rename to arch/arm/plat-samsung/time.c
index 3b27b29..2231d80 100644
--- a/arch/arm/plat-s3c/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/time.c
+/* linux/arch/arm/plat-samsung/time.c
  *
  * Copyright (C) 2003-2005 Simtec Electronics
  *	Ben Dooks, <ben@simtec.co.uk>
-- 
1.6.0.4
