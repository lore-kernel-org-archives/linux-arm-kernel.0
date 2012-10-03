From: prabhakar.csengg@gmail.com (Prabhakar)
Date: Wed,  3 Oct 2012 12:05:00 +0530
Subject: [PATCH] ARM: davinci: dm644x: fix out range signal for ED
Message-ID: <1349246100-7477-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.lad@ti.com>

while testing display on dm644x, for ED out-range signals
was observed. This patch fixes appropriate clock setting
for ED.

Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/dm644x.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 79d2880..688484b 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -713,8 +713,7 @@ static int dm644x_venc_setup_clock(enum vpbe_enc_timings_type type,
 		break;
 	case VPBE_ENC_CUSTOM_TIMINGS:
 		if (pclock <= 27000000) {
-			v |= DM644X_VPSS_MUXSEL_PLL2_MODE |
-			     DM644X_VPSS_DACCLKEN;
+			v |= DM644X_VPSS_DACCLKEN;
 			writel(v, DAVINCI_SYSMOD_VIRT(SYSMOD_VPSS_CLKCTL));
 		} else {
 			/*
-- 
1.7.4.1
