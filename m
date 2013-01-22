From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Jan 2013 22:10:25 +0100
Subject: [PATCH v3 3/3] arm: mvebu: enable gpio expander over i2c on Mirabox
 platform
In-Reply-To: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
References: <1358889025-8530-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1358889025-8530-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox platform can be connected to the JTAG/GPIO box
through the Multi-IO port. The GPIO box use the NXP PCA9505 I/O port
expansion IC to provide 40-bit parallel input/output GPIOs. This patch
enable the use of this expander on the Mirabox.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/armada-370-mirabox.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 3b40713..d9b32d3 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -52,5 +52,15 @@
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
+		i2c at d0011000 {
+			status = "okay";
+			clock-frequency = <100000>;
+			pca9505: pca9505 at 25 {
+				compatible = "nxp,pca9505";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x25>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
