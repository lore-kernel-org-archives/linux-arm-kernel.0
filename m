From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Mar 2013 09:54:24 -0300
Subject: [PATCH 4/5] ARM: mvebu: Add support for NOR flash device on
 Openblocks AX3 board
In-Reply-To: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1362660865-2755-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1362660865-2755-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Plat'home Openblocks AX3 has a 128 MiB NOR flash device connected
to the Device Bus. This commit adds the device tree node to support this device.

The SoC supports a flexible and dynamic decoding window allocation scheme;
but since this feature is still not implemented we need to specify the window
base address in the device tree node itself.
This base address has been selected in a completely arbitrary fashion.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 3818a82..15cdc5b 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -139,5 +139,17 @@
 		usb at d0051000 {
 			status = "okay";
 		};
+
+		device-bus at d0010400 {
+			status = "okay";
+			ranges = <0 0 0xf0000000 0x8000000>; /* CS0 @addr 0xf000000, size 0x8000000 */
+
+			/* CS0, 128 MiB */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0 0x8000000>;
+				bank-width = <2>;
+			};
+		};
 	};
 };
-- 
1.7.8.6
