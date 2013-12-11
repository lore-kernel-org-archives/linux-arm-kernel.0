From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 13:13:26 +0000
Subject: [PATCH 6/6] arm64: dts: Add CPU topology properties for ARMv8 4xA53
 4xA57 FVP
In-Reply-To: <1386767606-6391-1-git-send-email-broonie@kernel.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
Message-ID: <1386767606-6391-6-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

This provides for discovery of the clusters using the CPU topology
bindings, it is added as a separate commit to aid testing of the code
for systems without explicit topology bindings.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/boot/dts/fvp-base-gicv2-psci.dts | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/fvp-base-gicv2-psci.dts b/arch/arm64/boot/dts/fvp-base-gicv2-psci.dts
index 736f546123bb..452ba22f3c6e 100644
--- a/arch/arm64/boot/dts/fvp-base-gicv2-psci.dts
+++ b/arch/arm64/boot/dts/fvp-base-gicv2-psci.dts
@@ -119,6 +119,37 @@
 			enable-method = "psci";
 			clock-frequency = <1000000>;
 		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&big0>;
+				};
+				core1 {
+					cpu = <&big1>;
+				};
+				core2 {
+					cpu = <&big2>;
+				};
+				core3 {
+					cpu = <&big3>;
+				};
+			};
+			cluster1 {
+				core0 {
+					cpu = <&little0>;
+				};
+				core1 {
+					cpu = <&little1>;
+				};
+				core2 {
+					cpu = <&little2>;
+				};
+				core3 {
+					cpu = <&little3>;
+				};
+			};
+		};
 	};
 
 	memory at 80000000 {
-- 
1.8.5.1
