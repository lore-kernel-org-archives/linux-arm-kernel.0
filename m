From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:29 +0100
Subject: [PATCH 18/20] dts: sama5d2: Update coresight bindings for hardware
 ports
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-19-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new coresight bindings for hardware ports

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5..92ce7b8 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -86,8 +86,9 @@
 
 		port {
 			etb_in: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&etm_out>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -101,7 +102,9 @@
 
 		port {
 			etm_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&etb_in>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
-- 
2.7.4
