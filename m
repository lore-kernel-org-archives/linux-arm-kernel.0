From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 18 Sep 2015 03:20:28 +0200
Subject: [PATCH v3 23/26] ARM: pxa: magician: Remove definition of the STUART
 port
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Message-ID: <55FB66DC.4090303@tul.cz>
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
index a588fbc..386e6f0 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -1088,7 +1088,6 @@ static void __init magician_init(void)
 
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
-	pxa_set_stuart_info(NULL);
 
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
-- 
1.7.12.1
