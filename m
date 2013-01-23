From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 23 Jan 2013 12:26:31 -0300
Subject: [PATCH v2 2/3] arm: mvebu: Enable USB controllers on Armada 370/XP
 boards
In-Reply-To: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1358954792-16160-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch activates every USB port provided by each SoC.
Except for Armada XP Openblocks AX3-4 board,
where we enable only the first two USB ports
until we have more information on the third one usage.

Cc: Lior Amsalem <alior@marvell.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Changes from v1:
 * Squashed separate per-board patches into this one,
   as suggested by Arnd.
 * Remove usb at d0052000 activation in OpenBlocks AX3-4
   until we have more information about it.

 arch/arm/boot/dts/armada-370-db.dts              |    8 ++++++++
 arch/arm/boot/dts/armada-370-mirabox.dts         |    8 ++++++++
 arch/arm/boot/dts/armada-xp-db.dts               |   12 ++++++++++++
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    6 ++++++
 4 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 8e66a7c..3d93902 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -74,5 +74,13 @@
 			status = "disabled";
 			/* No CD or WP GPIOs */
 		};
+
+		usb at d0050000 {
+			status = "okay";
+		};
+
+		usb at d0051000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 1864820..dd0c57d 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -62,5 +62,13 @@
 			 * Wifi/Bluetooth chip
 			 */
 		};
+
+		usb at d0050000 {
+			status = "okay";
+		};
+
+		usb at d0051000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index c7035c5..c84e1fe 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -97,5 +97,17 @@
 			status = "okay";
 			/* No CD or WP GPIOs */
 		};
+
+		usb at d0050000 {
+			status = "okay";
+		};
+
+		usb at d0051000 {
+			status = "okay";
+		};
+
+		usb at d0052000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index ec36864..3818a82 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -133,5 +133,11 @@
 			nr-ports = <2>;
 			status = "okay";
 		};
+		usb at d0050000 {
+			status = "okay";
+		};
+		usb at d0051000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.8.6
