From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:01 +0900
Subject: [PATCH 1/3] ARM: shmobile: r7s72100: genmai: Remove reference board
 file
In-Reply-To: <cover.1408670789.git.horms+renesas@verge.net.au>
References: <cover.1408670789.git.horms+renesas@verge.net.au>
Message-ID: <71d03dabd6d3141872e23effd00345afe2ea2dab.1408670789.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The genmai board now boots using the generic R7S72100 DT machine with
the same feature set as the board file. Remove the board file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile                 |  1 -
 arch/arm/mach-shmobile/board-genmai-reference.c | 35 -------------------------
 2 files changed, 36 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-genmai-reference.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fe3878a..a058ec3 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -63,7 +63,6 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
-obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
deleted file mode 100644
index bc52677..0000000
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Genmai board support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/kernel.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-
-static const char * const genmai_boards_compat_dt[] __initconst = {
-	"renesas,genmai",
-	NULL,
-};
-
-DT_MACHINE_START(GENMAI_DT, "genmai")
-	.init_early	= shmobile_init_delay,
-	.dt_compat	= genmai_boards_compat_dt,
-MACHINE_END
-- 
2.0.1
