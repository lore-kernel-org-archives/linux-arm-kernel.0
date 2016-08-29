From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 13:06:07 +0100
Subject: [PATCH 4/6] ARM: sa1100/badge4: remove commented out modem control
 initialisers
In-Reply-To: <20160829120531.GG1041@n2100.armlinux.org.uk>
References: <20160829120531.GG1041@n2100.armlinux.org.uk>
Message-ID: <E1beLKJ-0001Tp-8H@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the commented out modem control initialisers.  These are doing
nothing useful.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/badge4.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 63361b6d04e9..17d28b4dab5e 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -315,8 +315,6 @@ badge4_uart_pm(struct uart_port *port, u_int state, u_int oldstate)
 }
 
 static struct sa1100_port_fns badge4_port_fns __initdata = {
-	//.get_mctrl	= badge4_get_mctrl,
-	//.set_mctrl	= badge4_set_mctrl,
 	.pm		= badge4_uart_pm,
 };
 
-- 
2.1.0
