From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 2 Jun 2011 12:58:30 +0200
Subject: [PATCH v3 3/3] remove the now empty mach-s3c2410/irq.c
In-Reply-To: <201106021254.57644.heiko@sntech.de>
References: <201106021254.57644.heiko@sntech.de>
Message-ID: <201106021258.30979.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Heiko Stuebner <heiko@sntech.de>

---
 arch/arm/mach-s3c2410/Makefile |    1 -
 arch/arm/mach-s3c2410/irq.c    |   29 -----------------------------
 2 files changed, 0 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/irq.c

diff --git a/arch/arm/mach-s3c2410/Makefile b/arch/arm/mach-s3c2410/Makefile
index 0d468e9..8169535 100644
--- a/arch/arm/mach-s3c2410/Makefile
+++ b/arch/arm/mach-s3c2410/Makefile
@@ -10,7 +10,6 @@ obj-n				:=
 obj-				:=
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
-obj-$(CONFIG_CPU_S3C2410)	+= irq.o
 obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_CPU_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_PM)	+= pm.o sleep.o
diff --git a/arch/arm/mach-s3c2410/irq.c b/arch/arm/mach-s3c2410/irq.c
deleted file mode 100644
index 4428695..0000000
--- a/arch/arm/mach-s3c2410/irq.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/* linux/arch/arm/mach-s3c2410/irq.c
- *
- * Copyright (c) 2006 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/syscore_ops.h>
-
-#include <plat/cpu.h>
-#include <plat/pm.h>
-- 
1.7.1
