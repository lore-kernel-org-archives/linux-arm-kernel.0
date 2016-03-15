From: david@lechnology.com (David Lechner)
Date: Tue, 15 Mar 2016 17:37:51 -0500
Subject: [PATCH 3/5] ARM: davinci: da8xx: add cfgchip2 to resources
In-Reply-To: <1458081473-8223-1-git-send-email-david@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
Message-ID: <1458081473-8223-3-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb ohci driver has been change to not include mach/*, so we need
to pass the cfgchip2 address to the driver so that it can turn the usb
phy on and off.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index b0a6b52..9607b0c 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -148,6 +148,11 @@ static struct resource da8xx_usb11_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
+		.start	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG,
+		.end	= DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP2_REG + 4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
 		.start	= IRQ_DA8XX_IRQN,
 		.end	= IRQ_DA8XX_IRQN,
 		.flags	= IORESOURCE_IRQ,
-- 
1.9.1
