From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Jun 2016 11:35:56 -0700
Subject: [PATCH 3/3] ARM: dts: BCM5310x: Enable switch ports on SmartRG SR400AC
In-Reply-To: <1465583756-26740-1-git-send-email-f.fainelli@gmail.com>
References: <1465583756-26740-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1465583756-26740-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the port mapping for the SmartRG SR400ACE device.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 8b0c440b2e71..c219d33496cc 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -126,3 +126,43 @@
 &spi_nor {
 	status = "okay";
 };
+
+&srab {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch0port0: port at 0 {
+			reg = <0>;
+			label = "lan4";
+		};
+
+		switch0port1: port at 1 {
+			reg = <1>;
+			label = "lan3";
+		};
+
+		switch0port2: port at 2 {
+			reg = <2>;
+			label = "lan2";
+		};
+
+		switch0port3: port at 3 {
+			reg = <3>;
+			label = "lan1";
+		};
+
+		switch0port4: port at 4 {
+			reg = <4>;
+			label = "wan";
+		};
+
+		switch0port5: port at 5 {
+			reg = <5>;
+			label = "cpu";
+			ethernet = <&gmac0>;
+		};
+	};
+};
-- 
2.7.4
