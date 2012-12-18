From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Dec 2012 15:33:53 +0100
Subject: [PATCH 08/18] arm: mvebu: enable the SD card slot on Armada XP DB
 board
In-Reply-To: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1355841243-3254-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1355841243-3254-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP DB evaluation board has one SD card slot, directly
connected to the SDIO IP of the SoC, so we enable this
IP. Unfortunately, there are no GPIOs for card-detect and
write-protect.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 8e53b25..c7035c5 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -90,5 +90,12 @@
 			phy = <&phy3>;
 			phy-mode = "sgmii";
 		};
+
+		mvsdio at d00d4000 {
+			pinctrl-0 = <&sdio_pins>;
+			pinctrl-names = "default";
+			status = "okay";
+			/* No CD or WP GPIOs */
+		};
 	};
 };
-- 
1.7.9.5
