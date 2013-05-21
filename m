From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 19:53:09 +0200
Subject: [PATCH] arm: mvebu: enable two USB interfaces on the Armada XP GP
 board
Message-ID: <1369158789-3218-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP GP board has two USB slots: one on the front side and
one on the back side. This commit enables the two USB host controllers
that correspond to those wo USB slots.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 26ad06f..f63426e 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -101,6 +101,16 @@
 				phy-mode = "rgmii-id";
 			};
 
+			/* Front-side USB slot */
+			usb at 50000 {
+				status = "okay";
+			};
+
+			/* Back-side USB slot */
+			usb at 51000 {
+				status = "okay";
+			};
+
 			spi0: spi at 10600 {
 				status = "okay";
 
-- 
1.7.9.5
