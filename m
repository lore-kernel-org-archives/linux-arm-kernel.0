From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:34 +0100
Subject: [PATCH 3/4] ARM: shmobile: Typo s/MIPDR/MPIDR/
In-Reply-To: <cover.1454595116.git.horms+renesas@verge.net.au>
References: <cover.1454595116.git.horms+renesas@verge.net.au>
Message-ID: <e24f317c859f2d904d1eb87cbb503c309e6dead7.1454595116.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The ARM Multiprocessor Affinity Register is called "MPIDR".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp-scu.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index fa5248c52399..c0008a5aa4ca 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -27,7 +27,7 @@
  */
 ENTRY(shmobile_boot_scu)
 					@ r0 = SCU base address
-	mrc     p15, 0, r1, c0, c0, 5	@ read MIPDR
+	mrc     p15, 0, r1, c0, c0, 5	@ read MPIDR
 	and	r1, r1, #3		@ mask out cpu ID
 	lsl	r1, r1, #3		@ we will shift by cpu_id * 8 bits
 	ldr	r2, [r0, #8]		@ SCU Power Status Register
-- 
2.7.0.rc3.207.g0ac5344
