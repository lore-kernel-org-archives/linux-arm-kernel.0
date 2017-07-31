From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:05:39 +0200
Subject: [PATCH 4/5] ARM: shmobile: rcar-gen2: Correct arch timer frequency on
 RZ/G1E
In-Reply-To: <cover.1501512320.git.horms+renesas@verge.net.au>
References: <cover.1501512320.git.horms+renesas@verge.net.au>
Message-ID: <cd66fa4e0203fed9d8af6e1596ff8a68ede7fb1d.1501512320.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

According to the datasheet, the frequency of the ARM architecture timer
on RZ/G1E depends on the frequency of the ZS clock, just like on R-Car
E2 and V2H.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3bd505da3172..7ab1690fab82 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -70,7 +70,8 @@ void __init rcar_gen2_timer_init(void)
 	void __iomem *base;
 	u32 freq;
 
-	if (of_machine_is_compatible("renesas,r8a7792") ||
+	if (of_machine_is_compatible("renesas,r8a7745") ||
+	    of_machine_is_compatible("renesas,r8a7792") ||
 	    of_machine_is_compatible("renesas,r8a7794")) {
 		freq = 260000000 / 8;	/* ZS / 8 */
 		/* CNTVOFF has to be initialized either from non-secure
-- 
2.1.4
