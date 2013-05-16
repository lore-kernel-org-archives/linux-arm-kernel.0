From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 May 2013 12:27:21 +0100
Subject: [PATCH 1/6] ARM: ux500: Add Device Tree nodes for the ux500 Crypt
 device
In-Reply-To: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
References: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368703646-26418-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides information required to setup ux500-crypt when
booting with DT on the Snowball low-cost development platform.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi  |    9 +++++++++
 arch/arm/boot/dts/snowball.dts |    4 ++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index fd5794a..92fd4b74 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -755,5 +755,14 @@
 
 			status = "disabled";
 		};
+
+		cryp at a03cb000 {
+			compatible = "stericsson,ux500-cryp";
+			reg = <0xa03cb000 0x1000>;
+			interrupts = <0 15 0x4>;
+
+			v-ape-supply = <&db8500_vape_reg>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index db5db24..de585fd 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -350,5 +350,9 @@
 				};
 			};
 		};
+
+		cryp at a03cb000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.10.4
