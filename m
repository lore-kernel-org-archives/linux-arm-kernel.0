From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 21 Mar 2011 16:15:42 +0100
Subject: [PATCH] ARM: mxs Enable UART3 on TX28
Message-ID: <1300720545-14123-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mxs/mach-tx28.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index 8baea4d..52e05a1 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -94,6 +94,12 @@ static const iomux_cfg_t tx28_stk5v3_pads[] __initconst = {
 	MX28_PAD_AUART1_RTS__AUART1_RTS,
 	MX28_PAD_AUART1_CTS__AUART1_CTS,
 
+	/* UART3 */
+	MX28_PAD_AUART3_RX__AUART3_RX,
+	MX28_PAD_AUART3_TX__AUART3_TX,
+	MX28_PAD_AUART3_RTS__AUART3_RTS,
+	MX28_PAD_AUART3_CTS__AUART3_CTS,
+
 	/* CAN */
 	MX28_PAD_GPMI_RDY2__CAN0_TX,
 	MX28_PAD_GPMI_RDY3__CAN0_RX,
@@ -322,6 +328,7 @@ static void __init tx28_stk5v3_init(void)
 
 	mx28_add_duart(); /* UART1 */
 	mx28_add_auart(1); /* UART2 */
+	mx28_add_auart(3); /* UART3 */
 
 	tx28_add_fec0();
 	/* spi via ssp will be added when available */
@@ -343,6 +350,7 @@ static void __init tx28_stk5v4_init(void)
 
 	mx28_add_duart(); /* UART1 */
 	mx28_add_auart(1); /* UART2 */
+	mx28_add_auart(3); /* UART3 */
 
 	tx28_add_fec0();
 	/* spi via ssp will be added later */
-- 
1.5.6.5
