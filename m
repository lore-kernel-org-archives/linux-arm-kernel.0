From: t.remmet@phytec.de (Teresa Remmet)
Date: Thu, 5 Jan 2017 15:50:48 +0100
Subject: [PATCH 3/6] ARM: dts: am335x-phycore-som: Add i2c temp sensor
In-Reply-To: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
Message-ID: <1483627851-17996-4-git-send-email-t.remmet@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the i2c temperature sensor which is optionaly mounted
on the phyCORE-AM335x-R2 module.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 8060ce5..08d1134 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -120,6 +120,12 @@
 		reg = <0x2d>;
 	};
 
+	i2c_tmp102: temp at 4b {
+		compatible = "ti,tmp102";
+		reg = <0x4b>;
+		status = "disabled";
+	};
+
 	i2c_eeprom: eeprom at 52 {
 		compatible = "atmel,24c32";
 		pagesize = <32>;
-- 
1.9.1
