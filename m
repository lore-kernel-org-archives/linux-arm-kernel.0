From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2012 18:02:49 +0200
Subject: [PATCH V5 5/6] arm: mvebu: add Aurora L2 Cache Controller to the DT
In-Reply-To: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
References: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1348675370-16359-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
Tested-and-reviewed-by: Yehuda Yitschak <yehuday@marvell.com>
Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/boot/dts/armada-370.dtsi |    6 ++++++
 arch/arm/boot/dts/armada-xp.dtsi  |    7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 3228ccc..fa60478 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -20,6 +20,12 @@
 / {
 	model = "Marvell Armada 370 family SoC";
 	compatible = "marvell,armada370", "marvell,armada-370-xp";
+	L2: l2-cache {
+		compatible = "marvell,aurora-outer-cache";
+		reg = <0xd0008000 0x1000>;
+		cache-id-part = <0x100>;
+		wt-override;
+	};
 
 	mpic: interrupt-controller at d0020000 {
 	      reg = <0xd0020a00 0x1d0>,
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 71d6b5d..0186f62 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -22,6 +22,13 @@
 	model = "Marvell Armada XP family SoC";
 	compatible = "marvell,armadaxp", "marvell,armada-370-xp";
 
+	L2: l2-cache {
+		compatible = "marvell,aurora-system-cache";
+		reg = <0xd0008000 0x1000>;
+		cache-id-part = <0x100>;
+		wt-override;
+	};
+
 	mpic: interrupt-controller at d0020000 {
 	      reg = <0xd0020a00 0x1d0>,
 		    <0xd0021870 0x58>;
-- 
1.7.9.5
