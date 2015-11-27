From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:56:06 +0900
Subject: [PATCH] ARM: shmobile: r8a7793: proper constness with __initconst
In-Reply-To: <cover.1448586153.git.horms+renesas@verge.net.au>
References: <cover.1448586153.git.horms+renesas@verge.net.au>
Message-ID: <c29d387b0bffb3ccce76e4fcdad9bfa7344ba338.1448586153.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Both the pointer array and the pointed data have to be const when using
__initconst to be correct.  This also fixes LTO builds that otherwise
fail with section mismatch errors.

Fixes: ec60d95b4fac ("ARM: shmobile: Basic r8a7793 SoC support")
Signed-off-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
index 1d2825cb7a65..5fce87f7f254 100644
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
-- 
2.1.4
