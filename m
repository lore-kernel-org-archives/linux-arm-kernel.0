From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:09 +0100
Subject: [PATCH v2 10/20] arm: mvebu: enable the SDIO interface on the
 Globalscale Mirabox
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox uses the SDIO interface of the Armada 370 to
connect to a Wifi/Bluetooth SD8787 chip, so we enable the SDIO
interface of this board in its Device Tree file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-mirabox.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 3b40713..1864820 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -52,5 +52,15 @@
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
+
+		mvsdio at d00d4000 {
+			pinctrl-0 = <&sdio_pins2>;
+			pinctrl-names = "default";
+			status = "okay";
+			/*
+			 * No CD or WP GPIOs: SDIO interface used for
+			 * Wifi/Bluetooth chip
+			 */
+		};
 	};
 };
-- 
1.7.9.5
