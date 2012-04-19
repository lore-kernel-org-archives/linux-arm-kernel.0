From: mans@mansr.com (Mans Rullgard)
Date: Thu, 19 Apr 2012 18:56:21 +0100
Subject: [PATCH] ARM: OMAP2+: craneboard: register emac device
Message-ID: <1334858181-7232-1-git-send-email-mans@mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the required am35xx_emac_init() call to the craneboard init
function.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index c3851e8..3b8a53c 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -30,6 +30,7 @@
 #include "common.h"
 #include <plat/usb.h>
 
+#include "am35xx-emac.h"
 #include "mux.h"
 #include "control.h"
 
@@ -90,6 +91,7 @@ static void __init am3517_crane_init(void)
 	}
 
 	usbhs_init(&usbhs_bdata);
+	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
-- 
1.7.8.5
