From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 16:13:30 +0100
Subject: [PATCH 1/3] ARM: shmobile: Typo s/MIPDR/MPIDR/
In-Reply-To: <1453994012-12696-1-git-send-email-geert+renesas@glider.be>
References: <1453994012-12696-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1453994012-12696-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Multiprocessor Affinity Register is called "MPIDR".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/headsmp-scu.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 5e503d91ad70ddf2..936d7011c3141b73 100644
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
1.9.1
