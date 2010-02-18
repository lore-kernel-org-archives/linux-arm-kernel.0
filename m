From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 18 Feb 2010 20:29:24 +0000
Subject: [PATCH 2/5] Correct the USB host initialisation flags of
	Arcom/Eurotech Zeus SBC.
Message-ID: <20100218202924.6d2633d8@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Amit Walambe <amit.walambe@eurotech.com>
Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/zeus.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 75f2a37..4034b98 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -509,7 +509,9 @@ static void zeus_ohci_exit(struct device *dev)
 
 static struct pxaohci_platform_data zeus_ohci_platform_data = {
 	.port_mode	= PMM_NPS_MODE,
-	.flags		= ENABLE_PORT_ALL | POWER_CONTROL_LOW | POWER_SENSE_LOW,
+	/* Clear Power Control Polarity Low and set Power Sense
+	 * Polarity Low. Supply power to USB ports. */
+	.flags		= ENABLE_PORT_ALL | POWER_SENSE_LOW,
 	.init		= zeus_ohci_init,
 	.exit		= zeus_ohci_exit,
 };
-- 
1.7.0



-- 
I'm the slime oozin' out from your TV set...
