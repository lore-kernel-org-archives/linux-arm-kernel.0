From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:27 +0100
Subject: [PATCH 16/20] dts: arm: omap: Update coresight bindings for hardware
 ports
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-17-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new coresight bindings for hardware ports

Cc: linux-omap at vger.kernel.org
Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 5 ++++-
 arch/arm/boot/dts/omap3-beagle.dts    | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 0349fcc..b5f40069 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -155,8 +155,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb_in: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&etm_out>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -169,7 +170,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm_out: endpoint {
+				direction = <1>;
 				remote-endpoint = <&etb_in>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3ca8991..b32e35b 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -149,8 +149,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb_in: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&etm_out>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -163,7 +164,9 @@
 		clock-names = "apb_pclk";
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
