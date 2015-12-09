From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Dec 2015 15:58:11 +0000
Subject: [PATCH v6 04/10] ARM: STi: STiH407: Provide generic (safe) DVFS
 configuration
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1449676697-25432-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You'll notice that the voltage cell is populated with 0's.  Voltage
information is very platform specific, even depends on 'cut' and
'substrate' versions.  Thus it is left blank for a generic (safe)
implementation.  If other nodes/properties are provided by the
bootloader, the ST CPUFreq driver will over-ride these generic
values.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 81f8121..9fa1e58 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -22,15 +22,29 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
+
 			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
 			cpu-release-addr = <0x94100A4>;
+
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 		cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
+
 			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
 			cpu-release-addr = <0x94100A4>;
+
+					 /* kHz     uV   */
+			operating-points = <1500000 0
+					    1200000 0
+					    800000  0
+					    500000  0>;
 		};
 	};
 
-- 
1.9.1
