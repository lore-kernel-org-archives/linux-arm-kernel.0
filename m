From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Jun 2013 01:05:38 +0200
Subject: [PATCH 1/3] ARM: integrator: set local side PCI addresses right
Message-ID: <1372201538-25946-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This alters the local side address of the iospace to zero,
non prefetchable memory local side address to 0x00000000 and
prefetchable memory local side address to 0x10000000,
so as to match the values actually poked in by the driver.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index 03f23b7..b6b82ec 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -49,11 +49,11 @@
 		interrupts = <17>; /* Bus error IRQ */
 		ranges = <0x00000000 0 0x61000000 /* config space */
 			0x61000000 0 0x00100000 /* 16 MiB @ 61000000 */
-			0x01000000 0 0x60000000 /* I/O space */
+			0x01000000 0 0x0 /* I/O space */
 			0x60000000 0 0x00100000 /* 16 MiB @ 60000000 */
-			0x02000000 0 0x40000000 /* non-prefectable memory */
+			0x02000000 0 0x00000000 /* non-prefectable memory */
 			0x40000000 0 0x10000000 /* 256 MiB @ 40000000 */
-			0x42000000 0 0x50000000 /* prefetchable memory */
+			0x42000000 0 0x10000000 /* prefetchable memory */
 			0x50000000 0 0x10000000>; /* 256 MiB @ 50000000 */
 		interrupt-map-mask = <0xf800 0 0 0x7>;
 		interrupt-map = <
-- 
1.8.1.4
