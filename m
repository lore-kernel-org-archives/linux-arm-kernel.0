From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 26 May 2011 16:48:04 +0200
Subject: [PATCH][Trivial] ARM: remove duplicate include from
	arch/arm/mach-dove/common.c
In-Reply-To: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1105261130190.17400@swampdragon.chaosbits.net>
Message-ID: <20110526144804.GA31651@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jesper Juhl pointed out there is a redundant include of
linux/serial_8250.h. However it turns out both are redundant.
This patch removes them both.

Only compile tested.

Reported-by:  Jesper Juhl <jj@chaosbits.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-dove/common.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 5ed51b8..83dce85 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -13,11 +13,9 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/pci.h>
-#include <linux/serial_8250.h>
 #include <linux/clk.h>
 #include <linux/mbus.h>
 #include <linux/ata_platform.h>
-#include <linux/serial_8250.h>
 #include <linux/gpio.h>
 #include <asm/page.h>
 #include <asm/setup.h>
-- 
1.7.4.4
