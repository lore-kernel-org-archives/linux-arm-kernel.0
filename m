From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:40:23 +0200
Subject: [PATCH v4 23/26] ARM: pxa: magician: Remove definition of the STUART
 port
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609B3C7.8010808@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magician STUART port is connected to the infraport and used by the FICP
driver. The FICP driver uses its own definition.

Required for correct initialization of the pxaficp_ir driver after
planned dmaengine conversion.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 8a90b90..c89f2a8 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -1088,7 +1088,6 @@ static void __init magician_init(void)
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
 
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
-- 
1.7.12.1
