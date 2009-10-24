From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:04:03 +0400
Subject: [PATCH 05/20] SA1100: h3600: stop setting direction for LCD pins
In-Reply-To: <1256414658-22611-5-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-2-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-3-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-4-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-5-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414658-22611-6-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sa1100_fb driver handles this

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3600.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 5033c03..021cecb 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -464,9 +464,7 @@ static void __init h3600_map_io(void)
 	GPCR = 0x0fffffff;	 /* All outputs are set low by default */
 	GPDR = GPIO_H3600_L3_CLOCK |
 	       GPIO_H3600_L3_MODE  | GPIO_H3600_L3_DATA  |
-	       GPIO_H3600_CLK_SET1 | GPIO_H3600_CLK_SET0 |
-	       GPIO_LDD15 | GPIO_LDD14 | GPIO_LDD13 | GPIO_LDD12 |
-	       GPIO_LDD11 | GPIO_LDD10 | GPIO_LDD9  | GPIO_LDD8;
+	       GPIO_H3600_CLK_SET1 | GPIO_H3600_CLK_SET0;
 
 	H3600_EGPIO = h3600_egpio;	   /* Maintains across sleep? */
 	assign_h3600_egpio = h3600_control_egpio;
-- 
1.6.5.1.63.ga9d7.dirty
