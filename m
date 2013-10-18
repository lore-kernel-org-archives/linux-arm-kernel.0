From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 18 Oct 2013 20:02:53 -0300
Subject: [PATCH v2 26/27] ARM: mvebu: Enable NAND controller in Armada XP GP
 board
In-Reply-To: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1382137374-21251-27-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP GP board has a NAND flash, so enable it in the devicetree.

In order to skip the driver's custom device detection and use only ONFI
detection, the "marvell,keep-config" parameter is used.
This is needed because we haven't support for setting the timings
parameters yet and must rely in bootloader's.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 2298e4a..274e2ad 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -175,6 +175,14 @@
 					spi-max-frequency = <108000000>;
 				};
 			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+			};
 		};
 	};
 };
-- 
1.8.1.5
