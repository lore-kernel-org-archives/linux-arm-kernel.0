From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 Apr 2014 15:50:21 +0200
Subject: [PATCH 3/3] ARM: mvebu: use qsgmii phy-mode for Armada XP GP
 interfaces
In-Reply-To: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397569821-5530-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP GP isn't using rgmii-id connections between the MAC and
PHY, but instead a single QSGMII connection, which is a quad-SGMII
connection: a double pair of differential lines that are multiplexed
to convey the traffic of four network interfaces between a MAC and a
PHY.

Until now, the Armada XP GP was relying on the bootloader setting the
correct values in various configuration registers. With this change,
the mvneta driver can be used as a module on this platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 61bda68..c921f3b 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -146,22 +146,22 @@
 			ethernet at 70000 {
 				status = "okay";
 				phy = <&phy0>;
-				phy-mode = "rgmii-id";
+				phy-mode = "qsgmii";
 			};
 			ethernet at 74000 {
 				status = "okay";
 				phy = <&phy1>;
-				phy-mode = "rgmii-id";
+				phy-mode = "qsgmii";
 			};
 			ethernet at 30000 {
 				status = "okay";
 				phy = <&phy2>;
-				phy-mode = "rgmii-id";
+				phy-mode = "qsgmii";
 			};
 			ethernet at 34000 {
 				status = "okay";
 				phy = <&phy3>;
-				phy-mode = "rgmii-id";
+				phy-mode = "qsgmii";
 			};
 
 			/* Front-side USB slot */
-- 
1.8.3.2
