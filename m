From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 21 Mar 2013 16:43:08 -0300
Subject: [PATCH] ARM: mvebu: Add button on Armada 370 Reference Design board
Message-ID: <1363894988-3181-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 370 Reference Design board has a software-controlled
button on the front side, marked as "SW".
This patch adds minimal support for this button.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-rd.dts |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index f8e4855..df3fdf4 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -65,4 +65,15 @@
 			/* No CD or WP GPIOs */
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "Software Button";
+			linux,code = <116>;
+			gpios = <&gpio0 6 1>;
+		};
+	};
 };
-- 
1.7.8.6
