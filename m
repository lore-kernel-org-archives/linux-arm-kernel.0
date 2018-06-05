From: nm@ti.com (Nishanth Menon)
Date: Tue, 5 Jun 2018 01:01:23 -0500
Subject: [RFC PATCH 4/6] serial: 8250_omap: Make 8250_omap driver driver
 depend on ARCH_K3
In-Reply-To: <20180605060125.9518-1-nm@ti.com>
References: <20180605060125.9518-1-nm@ti.com>
Message-ID: <20180605060125.9518-5-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Allow 8250 omap serial driver to be used for K3 platforms.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/tty/serial/8250/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index f005eaf8bc57..15c2c5463835 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -375,7 +375,7 @@ config SERIAL_8250_RT288X
 
 config SERIAL_8250_OMAP
 	tristate "Support for OMAP internal UART (8250 based driver)"
-	depends on SERIAL_8250 && ARCH_OMAP2PLUS
+	depends on SERIAL_8250 && (ARCH_OMAP2PLUS || ARCH_K3)
 	help
 	  If you have a machine based on an Texas Instruments OMAP CPU you
 	  can enable its onboard serial ports by enabling this option.
-- 
2.15.1
