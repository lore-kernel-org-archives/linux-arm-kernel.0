From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 27 Feb 2018 16:01:57 +0000
Subject: [PATCH 1/2] ARM: dts: armada388-clearfog: increase speed of i2c0 to
 400kHz
In-Reply-To: <20180227160135.GU9418@n2100.armlinux.org.uk>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
Message-ID: <E1eqhhV-0004ku-Nd@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the devices on I2C0 support fast mode, so increase the bus speed
to match.  The Armada 388 is known to have a timing issue when in
standard mode, which we believe causes the ficticious device at 0x64
to appear.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-388-clearfog.dtsi | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-clearfog.dtsi b/arch/arm/boot/dts/armada-388-clearfog.dtsi
index 68acfc968706..0e3b1f140e6d 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dtsi
+++ b/arch/arm/boot/dts/armada-388-clearfog.dtsi
@@ -143,8 +143,7 @@
 };
 
 &i2c0 {
-	/* Is there anything on this? */
-	clock-frequency = <100000>;
+	clock-frequency = <400000>;
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
 	status = "okay";
@@ -239,13 +238,11 @@
 		};
 	};
 
-	/* The MCP3021 is 100kHz clock only */
+	/* The MCP3021 supports standard and fast modes */
 	mikrobus_adc: mcp3021 at 4c {
 		compatible = "microchip,mcp3021";
 		reg = <0x4c>;
 	};
-
-	/* Also something at 0x64 */
 };
 
 &i2c1 {
-- 
2.7.4
