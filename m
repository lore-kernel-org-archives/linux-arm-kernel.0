From: florian@openwrt.org (Florian Fainelli)
Date: Tue,  5 Mar 2013 10:55:04 +0100
Subject: [PATCH] arm: mvebu: enable the USB ports on Armada 370 Reference
 Design board
Message-ID: <1362477304-22143-1-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the Armada 370 Reference Design DTS file to enable
support for the two USB ports found on this board.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Jason,

Since this board was added after USB support was added to Marvell
Armada XP/370, I would appreciate if you could fold this into a
pull request for 3.9-rc2 for instance.

Thanks!

 arch/arm/boot/dts/armada-370-rd.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index f8e4855..070bba4 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -64,5 +64,13 @@
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
 	};
 };
-- 
1.7.10.4
