From: ben-linux@fluff.org (Ben Dooks)
Date: Fri,  8 Jan 2010 02:30:19 +0000
Subject: [S3C-CLK] ARM: SAMSUNG: Move clock.c to arch/arm/plat-samsung
In-Reply-To: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
References: <1262917822-26004-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1262917822-26004-12-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the core implementation of the clock code for all Samsung based
SoCs, so move it to arch/arm/plat-samsung (the clock.h file has already
been moved).

Since the file is built for every Samsung SoC, no changes are needed to the
Kconfig system.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/Makefile                  |    3 +--
 arch/arm/plat-samsung/Makefile              |    4 ++++
 arch/arm/{plat-s3c => plat-samsung}/clock.c |    0
 3 files changed, 5 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-s3c => plat-samsung}/clock.c (100%)

diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 50444da..99f91ad 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -11,9 +11,8 @@ obj-				:=
 
 # Core support for all Samsung SoCs
 
-obj-y				+=  init.o
+obj-y				+= init.o
 obj-y				+= time.o
-obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 obj-y				+= gpio.o
 obj-y				+= gpio-config.o
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index ce736ce..7612198 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -9,4 +9,8 @@ obj-m				:=
 obj-n				:= dummy.o
 obj-				:=
 
+# Objects we always build independent of SoC choice
+
+obj-y				+= clock.o
+
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
diff --git a/arch/arm/plat-s3c/clock.c b/arch/arm/plat-samsung/clock.c
similarity index 100%
rename from arch/arm/plat-s3c/clock.c
rename to arch/arm/plat-samsung/clock.c
-- 
1.6.0.4
