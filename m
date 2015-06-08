From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon,  8 Jun 2015 17:16:59 +0100
Subject: [PATCH 2/2] ARM: STi: DT: STiH407: Add cpu-release-addr dt property.
In-Reply-To: <1433780219-1245-1-git-send-email-peter.griffin@linaro.org>
References: <1433780219-1245-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433780219-1245-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable SMP when booting via u-boot we need to specify the
newly implemented cpu-release-addr DT property.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c06a546..3c90227 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -19,11 +19,15 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
+			cpu-release-addr = <0x94100A4>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
+			cpu-release-addr = <0x94100A4>;
 		};
 	};
 
-- 
1.9.1
