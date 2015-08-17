From: petr.cvek@tul.cz (Petr Cvek)
Date: Tue, 18 Aug 2015 00:03:28 +0200
Subject: [PATCH v2 14/21] ARM: pxa: magician: Fix PXA USB OHCI port enable
 flags
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Message-ID: <55D25A30.9000002@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix PXA USB OHCI port enable flags.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 50c5325..d17125e 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -1065,8 +1065,10 @@ static struct platform_device magician_audio_device = {
 
 static struct pxaohci_platform_data magician_ohci_info = {
 	.port_mode	= PMM_PERPORT_MODE,
-	.flags		= ENABLE_PORT1 | ENABLE_PORT3 | POWER_CONTROL_LOW,
+	/* port1: CSR Bluetooth, port2: OTG with UDC */
+	.flags		= ENABLE_PORT1 | ENABLE_PORT2 | POWER_CONTROL_LOW,
 	.power_budget	= 0,
+	.power_on_delay = 100,
 };
 
 /*
-- 
1.7.12.1
