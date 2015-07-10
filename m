From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:07 +0900
Subject: [PATCH 2/8] ARM: shmobile: R-Car: Shrink rcar_sysc_ch size
In-Reply-To: <cover.1436510166.git.horms+renesas@verge.net.au>
References: <cover.1436510166.git.horms+renesas@verge.net.au>
Message-ID: <6fd2242e60e89a26e731e57dbf8f88d6639e09de.1436510166.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Shrink the individual fields in struct rcar_sysc_ch, as unsigned long or
int is overkill:
  - chan_offs contains a register offset relative to a base value
    (< 512),
  - chan_bit and isr_bit contain bit indices (0-31).

This reduces the size of each instance from 3 (4 on 64-bit) 32-bit words
to 1 32-bit word.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rcar.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/arch/arm/mach-shmobile/pm-rcar.h
index ef3a1ef628f1..06ebf00a6a5a 100644
--- a/arch/arm/mach-shmobile/pm-rcar.h
+++ b/arch/arm/mach-shmobile/pm-rcar.h
@@ -2,9 +2,9 @@
 #define PM_RCAR_H
 
 struct rcar_sysc_ch {
-	unsigned long chan_offs;
-	unsigned int chan_bit;
-	unsigned int isr_bit;
+	u16 chan_offs;
+	u8 chan_bit;
+	u8 isr_bit;
 };
 
 int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
-- 
2.1.4
