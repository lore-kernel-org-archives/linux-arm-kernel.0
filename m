From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:26:28 +0000
Subject: [PATCH 12/31] ARM: amba: mxs: get rid of NO_IRQ initializers
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAjs-0005F5-2V@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-mxs/devices/amba-duart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/devices/amba-duart.c b/arch/arm/mach-mxs/devices/amba-duart.c
index a559db0..a5479f7 100644
--- a/arch/arm/mach-mxs/devices/amba-duart.c
+++ b/arch/arm/mach-mxs/devices/amba-duart.c
@@ -23,7 +23,7 @@ const struct amba_device name##_device __initconst = {		\
 		.end = (soc ## _DUART_BASE_ADDR) + SZ_8K - 1,	\
 		.flags = IORESOURCE_MEM,			\
 	},							\
-	.irq = {soc ## _INT_DUART, NO_IRQ},			\
+	.irq = {soc ## _INT_DUART},				\
 }
 
 #ifdef CONFIG_SOC_IMX23
-- 
1.7.4.4
