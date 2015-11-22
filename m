From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 21 Nov 2015 20:41:07 -0500 (EST)
Subject: [PATCH] mach-shmobile/setup-r8a7793.c: proper constness with
 __initconst
Message-ID: <alpine.LFD.2.20.1511212036580.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the pointer array and the pointed data have to be const when using
__initconst to be correct.  This also fixes LTO builds that otherwise
fail with section mismatch errors.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
index 1d2825cb7a..5fce87f7f2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7793.c
+++ b/arch/arm/mach-shmobile/setup-r8a7793.c
@@ -19,7 +19,7 @@
 #include "common.h"
 #include "rcar-gen2.h"
 
-static const char *r8a7793_boards_compat_dt[] __initconst = {
+static const char * const r8a7793_boards_compat_dt[] __initconst = {
 	"renesas,r8a7793",
 	NULL,
 };
