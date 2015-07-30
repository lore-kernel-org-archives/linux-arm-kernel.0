From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 30 Jul 2015 11:23:21 +0200
Subject: [PATCH v2 5/5] ARM: berlin: add a PWM node on the BG2CD
In-Reply-To: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1438248201-29222-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a PWM node in the Berlin BG2CD device tree, using the
newly added Berlin PWM driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 900213d78a32..0503ca095acb 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -446,5 +446,11 @@
 				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
+
+		pwm: pwm at f20000 {
+			compatible = "marvell,berlin-pwm";
+			reg = <0xf20000 0x40>;
+			#pwm-cells = <3>;
+		};
 	};
 };
-- 
2.5.0
