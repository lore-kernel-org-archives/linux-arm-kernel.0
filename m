From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Feb 2015 11:32:08 +0100
Subject: [PATCH v4 2/2] ARM: mvebu: a385-db-ap: Enable the NAND
In-Reply-To: <1424255528-1717-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1424255528-1717-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1424255528-1717-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 385 Access Point Development Board has a 1GB NAND SLC chip from
Micron as its main storage. Enable it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db-ap.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
index b891b4c897f5..ee648fb19075 100644
--- a/arch/arm/boot/dts/armada-385-db-ap.dts
+++ b/arch/arm/boot/dts/armada-385-db-ap.dts
@@ -130,6 +130,19 @@
 				phy-mode = "rgmii-id";
 			};
 
+			nfc: flash at d0000 {
+				status = "okay";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				num-cs = <1>;
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+			};
+
 			usb3 at f0000 {
 				status = "okay";
 				usb-phy = <&usb3_phy>;
-- 
2.3.0
