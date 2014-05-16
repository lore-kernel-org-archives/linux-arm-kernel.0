From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 May 2014 16:14:07 +0200
Subject: [PATCHv4 5/5] ARM: mvebu: use the fixed-link PHY DT binding for the
 Armada XP Matrix board
In-Reply-To: <1400249647-4643-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400249647-4643-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400249647-4643-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP Matrix board has an Ethernet PHY that isn't configurable
through the MDIO bus, so we use the newly introduced fixed-link PHY DT
binding to represent the PHY of this platform and get network working.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-matrix.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index c224274..3bb8c00 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -61,6 +61,10 @@
 			ethernet at 30000 {
 				status = "okay";
 				phy-mode = "sgmii";
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
 			};
 
 			pcie-controller {
-- 
1.9.3
