From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 20 Mar 2013 19:36:35 -0300
Subject: [PATCH 14/16] ARM: mvebu: Add thermal support to Armada XP device tree
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1363818997-23137-15-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch depends on the patch to support Armada XP
in mvebu_thermal driver:
'thermal: mvebu: Add support for Armada XP thermal sensor'

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 1443949..d85fa6a 100644
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
