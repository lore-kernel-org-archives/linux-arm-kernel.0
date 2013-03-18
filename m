From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:07:16 +0900
Subject: [PATCH 140/142] ARM: shmobile: r8a7779: Remove USB function GPIOs
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-141-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Those GPIOs have been deprecated by the pinctrl API. They are unused and
unneeded, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index f3ae551..e50bf53 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -71,7 +71,7 @@ enum {
 	GPIO_FN_A19,
 
 	/* IPSR0 */
-	GPIO_FN_USB_PENC2, GPIO_FN_PWM1, GPIO_FN_PWMFSW0,
+	GPIO_FN_PWM1, GPIO_FN_PWMFSW0,
 	GPIO_FN_SCIF_CLK, GPIO_FN_TCLK0_C, GPIO_FN_BS,
 	GPIO_FN_FD2, GPIO_FN_ATADIR0, GPIO_FN_SDSELF,
 	GPIO_FN_HCTS1, GPIO_FN_A0,
@@ -191,7 +191,7 @@ enum {
 	GPIO_FN_VI1_FIELD, GPIO_FN_VI3_FIELD,
 	GPIO_FN_AUDIO_CLKOUT, GPIO_FN_GPS_CLK_C,
 	GPIO_FN_GPS_CLK_D, GPIO_FN_AUDIO_CLKA, GPIO_FN_CAN_TXCLK,
-	GPIO_FN_AUDIO_CLKB, GPIO_FN_USB_OVC2, GPIO_FN_CAN_DEBUGOUT0,
+	GPIO_FN_AUDIO_CLKB, GPIO_FN_CAN_DEBUGOUT0,
 	GPIO_FN_MOUT0,
 
 	/* IPSR6 */
@@ -230,10 +230,10 @@ enum {
 	GPIO_FN_DREQ2,	GPIO_FN_DACK2,
 
 	/* IPSR8 */
-	GPIO_FN_USB_OVC0, GPIO_FN_AD_CLK,
+	GPIO_FN_AD_CLK,
 	GPIO_FN_CC5_STATE4, GPIO_FN_CC5_STATE12, GPIO_FN_CC5_STATE20,
 	GPIO_FN_CC5_STATE28, GPIO_FN_CC5_STATE36,
-	GPIO_FN_USB_OVC1, GPIO_FN_AD_DI,
+	GPIO_FN_AD_DI,
 	GPIO_FN_CC5_STATE5, GPIO_FN_CC5_STATE13, GPIO_FN_CC5_STATE21,
 	GPIO_FN_CC5_STATE29, GPIO_FN_CC5_STATE37,
 	GPIO_FN_CAN_DEBUG_HW_TRIGGER, GPIO_FN_AD_DO,
-- 
1.7.10.4
