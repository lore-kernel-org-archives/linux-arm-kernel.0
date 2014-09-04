From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:37 +0900
Subject: [PATCH 6/9] ARM: shmobile: Only select PM_RMOBILE for legacy case
In-Reply-To: <cover.1409792454.git.horms+renesas@verge.net.au>
References: <cover.1409792454.git.horms+renesas@verge.net.au>
Message-ID: <46bff9db49d7995f824add28122e2a694d54d6de.1409792454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the ARM mach-shmobile Kconfig bits to only
select PM_RMOBILE in case of legacy. This allows us
to enable partial multiplatform support for various
SoCs before Power Domains DT bindings are finalized.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9295776..42d9de0 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -21,7 +21,7 @@ config ARCH_RCAR_GEN2
 
 config ARCH_RMOBILE
 	bool
-	select PM_RMOBILE if PM
+	select PM_RMOBILE if PM && !ARCH_SHMOBILE_MULTI
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
-- 
2.0.1
