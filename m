From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  7 Jan 2013 17:42:07 +0100
Subject: [PATCH 3.9 2/3] arm: mvebu: add the 7-segment display DT informations
 to Armada 370 DB
In-Reply-To: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1357576928-29133-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a 7-segment display driver in the kernel, use it on
the Marvell Armada 370 DB evaluation board.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 0004402..c433072 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -59,5 +59,10 @@
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
+		gpio-7seg at 0 {
+			compatible = "generic,gpio-7seg";
+			status = "okay";
+			gpios = <&gpio1 27 0 &gpio1 28 0 &gpio1 29 0>;
+		};
 	};
 };
-- 
1.7.9.5
