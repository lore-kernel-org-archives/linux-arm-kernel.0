From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 6 Jan 2014 08:36:50 -0400
Subject: [PATCHv2 6/7] arm: dts: add tmp102 i2c sensor node on dra7-evm
In-Reply-To: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1389011811-13004-7-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On dra7-evm there is an tmp102 temperature sensor on i2c bus 1.
This patch adds its device tree node.

Cc: Beno?t Cousson <bcousson@baylibre.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..36e2c9e 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -212,6 +212,13 @@
 			};
 		};
 	};
+
+	tmp102: tmp102 at 48 {
+		compatible = "ti,tmp102";
+		reg = <0x48>;
+
+		#thermal-sensor-cells = <0>;
+	};
 };
 
 &i2c2 {
-- 
1.8.2.1.342.gfa7285d
