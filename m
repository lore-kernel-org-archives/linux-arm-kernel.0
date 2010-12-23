From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 Dec 2010 10:50:31 +0200
Subject: [PATCH 2/2] arm: omap: tusb6010: add name for MUSB IRQ
In-Reply-To: <1293094231-3270-1-git-send-email-balbi@ti.com>
References: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
	<1293094231-3270-1-git-send-email-balbi@ti.com>
Message-ID: <1293094231-3270-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit fcf173e4511193b1efeccb0f22a8c641b464353b
(add names for IRQs in structure resource)
forgot to take care of tusb6010 making it
fail to probe due to a missing resource.

Fix it.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/usb-tusb6010.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 1e998ea..30f112b 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -216,6 +216,7 @@ static struct resource tusb_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{ /* IRQ */
+		.name	= "mc",
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.3.4.598.g85356
