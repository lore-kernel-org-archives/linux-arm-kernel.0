From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 26 Mar 2013 07:16:26 -0300
Subject: [PATCH v2 2/4] ARM: mvebu: Add thermal support to Armada XP device
 tree
In-Reply-To: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1364292988-8358-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the thermal controller available in
all Armada XP boards. This controller has two 4-byte registers:
one to read the thermal sensor, the other for sensor initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
This patch depends on the patch to support Armada XP thermal driver:
'thermal: Add driver for Armada 370/XP SoC thermal management'

 arch/arm/boot/dts/armada-xp.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index ca00d83..29dfeb6 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -151,5 +151,11 @@
 			status = "disabled";
 		};
 
+		thermal at d00182b0 {
+			compatible = "marvell,armadaxp-thermal";
+			reg = <0xd00182b0 0x4
+			       0xd00184d0 0x4>;
+			status = "okay";
+		};
 	};
 };
-- 
1.7.8.6
