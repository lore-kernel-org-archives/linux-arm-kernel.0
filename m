From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 25 Mar 2013 12:27:08 -0300
Subject: [PATCH 3/4] ARM: mvebu: Add thermal support to Armada 370 device tree
In-Reply-To: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1364225229-2857-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the thermal controller available in
all Armada 370 boards. This controller has two 4-byte registers:
one to read the thermal sensor, the other for sensor initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
This patch depends on the patch to support Armada 370 thermal driver:
'thermal: Add driver for Armada 370/XP SoC thermal management'

 arch/arm/boot/dts/armada-370.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 8188d13..5831994 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -153,5 +153,11 @@
 			clocks = <&coreclk 0>;
 		};
 
+		thermal at d0018300 {
+			compatible = "marvell,armada370-thermal";
+			reg = <0xd0018300 0x4
+			       0xd0018304 0x4>;
+			status = "okay";
+		};
 	};
 };
-- 
1.7.8.6
