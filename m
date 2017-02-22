From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 22 Feb 2017 03:29:22 +0100
Subject: [PATCH v2 2/8] tty: serial: Suppress deprecated SERIAL_PXA on arm64
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Message-ID: <20170222022929.10540-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With Marvell IAP140 being enabled as first arm64 MMP platform, don't
make the deprecated SERIAL_PXA option available outside ARM.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: split off
 * Updated for ARCH_MMP
 
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 6117ac8..db83085 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -439,7 +439,7 @@ config SERIAL_MPSC_CONSOLE
 
 config SERIAL_PXA
 	bool "PXA serial port support (DEPRECATED)"
-	depends on ARCH_PXA || ARCH_MMP
+	depends on ARCH_PXA || (ARCH_MMP && ARM)
 	select SERIAL_CORE
 	select SERIAL_8250_PXA if SERIAL_8250=y
 	select SERIAL_PXA_NON8250 if !SERIAL_8250=y
-- 
2.10.2
