From: florian@openwrt.org (Florian Fainelli)
Date: Fri,  1 Feb 2013 11:38:28 +0100
Subject: [PATCH] arm: mvebu: enable the SD card slot on Armada 370 Reference
 Design board
In-Reply-To: <20130131175743.GF7717@titan.lakedaemon.net>
References: <20130131175743.GF7717@titan.lakedaemon.net>
Message-ID: <1359715108-13982-1-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 Reference Design board has one SD card slot, directly
connected to the SDIO IP of the SoC, so we enable this IP. there are no
GPIOs for card-detect and write-protect so we do not specify any.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Jason,

This is against your mvebu/dt branch

 arch/arm/boot/dts/armada-370-rd.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index d62dfac..f8e4855 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -57,5 +57,12 @@
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
+
+		mvsdio at d00d4000 {
+			pinctrl-0 = <&sdio_pins1>;
+			pinctrl-names = "default";
+			status = "okay";
+			/* No CD or WP GPIOs */
+		};
 	};
 };
-- 
1.7.10.4
