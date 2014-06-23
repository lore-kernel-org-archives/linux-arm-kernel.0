From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 23 Jun 2014 12:59:29 +0100
Subject: [PATCH 5/5] ARM: dts: cubox-i: disable spread-spectrum for Cubox-i
 eSATA
Message-ID: <E1Wz2uH-0000eV-4K@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Spread-spectrum doesn't work with Cubox-i hardware.  eSATA devices are
detected, but then fail on normal IO.  Therefore, disable this feature.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6q-cubox-i.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6q-cubox-i.dts b/arch/arm/boot/dts/imx6q-cubox-i.dts
index 941365d7ee65..9efd8b0c8011 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i.dts
@@ -16,4 +16,5 @@
 	fsl,transmit-level-mV = <1104>;
 	fsl,transmit-boost-mdB = <0>;
 	fsl,transmit-atten-16ths = <9>;
+	fsl,no-spread-spectrum;
 };
-- 
1.8.3.1
