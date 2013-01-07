From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Jan 2013 17:42:08 +0100
Subject: [PATCH 3.9 3/3] arm: mvebu: add the 7-segment display DT informations
 to Armada XP DB
In-Reply-To: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1357576928-29133-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a 7-segment display driver in the kernel, use it on
the Marvell Armada XP DB evaluation board.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 8e53b25..8654c1b 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -90,5 +90,10 @@
 			phy = <&phy3>;
 			phy-mode = "sgmii";
 		};
+		gpio-7seg at 0 {
+			compatible = "generic,gpio-7seg";
+			status = "okay";
+			gpios = <&gpio0 26 0 &gpio0 27 0 &gpio1 16 0>;
+		};
 	};
 };
-- 
1.7.9.5
