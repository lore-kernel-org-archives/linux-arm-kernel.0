From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 28 Nov 2015 12:14:08 +0100
Subject: [PATCH 4/4] ARM: dt: mvebu: ix4-300d: Add ECC properties to NAND flash
In-Reply-To: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1448709248-21177-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1448709248-21177-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND device found on Lenovo ix4-300d uses 4-bit BCH ECC protection.
Add the corresponding properties to the NAND node.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com> 
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Pawel Moll <pawel.moll@arm.com> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
Cc: Kumar Gala <galak@codeaurora.org> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Benoit Masson <yahoo@perenite.com>
Cc: linux-arm-kernel at lists.infradead.org 
Cc: devicetree at vger.kernel.org 
Cc: linux-kernel at vger.kernel.org 
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 13cf69a8d0fb..e4bf83c4bd2f 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -150,6 +150,8 @@
 				marvell,nand-keep-config;
 				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
 
 				partitions {
 					#address-cells = <1>;
-- 
2.1.4
