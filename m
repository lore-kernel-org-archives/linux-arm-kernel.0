From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  8 Jul 2016 11:48:52 -0700
Subject: [PATCH 1/2] ARM: dts: NSP: Add Switch Register Access Block node
In-Reply-To: <1468003735-26895-1-git-send-email-f.fainelli@gmail.com>
References: <1468003735-26895-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1468003735-26895-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Switch Register Access Block node, this peripheral is identical
to the BCM5301x Northstar SoC, but we utilize the SoC-wide
"brcm,nsp-srab" compatible string to illustrate the integration
difference here.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 8d7b35a4b5f1..983fdba905e3 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -241,6 +241,17 @@
 			clock-names = "apb_pclk";
 		};
 
+		srab: srab at 36000 {
+			compatible = "brcm,nsp-srab";
+			reg = <0x36000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			/* ports are defined in board DTS */
+		};
+
 		i2c0: i2c at 38000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x38000 0x50>;
-- 
2.7.4
