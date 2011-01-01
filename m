From: michael.williamson@criticallink.com (Michael Williamson)
Date: Fri, 31 Dec 2010 20:11:57 -0500
Subject: [PATCH 2/2] davinci: mityomapl138 platform: disable MS interrupts on
	UART1
In-Reply-To: <1293844317-11757-1-git-send-email-michael.williamson@criticallink.com>
References: <1293844317-11757-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1293844317-11757-2-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All supported configurations of the MityDSP-l138 and MityARM-1808
SoMs use the pin associated with CTS on UART1 as either an AHCLKX
input or a USB_REFCLKIN input.  Disable modem status interrupts
associated with this pin.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 0bb5f0c..4d5315a 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -283,7 +283,8 @@ static void __init mityomapl138_setup_nand(void)
 }
 
 static struct davinci_uart_config mityomapl138_uart_config __initdata = {
-	.enabled_uarts = 0x7,
+	.enabled_uarts	= 0x7,
+	.disable_rtscts	= 0x2,
 };
 
 static const short mityomap_mii_pins[] = {
-- 
1.7.0.4
