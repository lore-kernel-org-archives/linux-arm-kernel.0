From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 May 2013 12:27:22 +0100
Subject: [PATCH 2/6] ARM: ux500: Add Device Tree nodes for the ux500 Hash
 device
In-Reply-To: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
References: <1368703646-26418-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1368703646-26418-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides information required to setup ux500-hash when
booting with DT on the Snowball low-cost development platform.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi  |    8 ++++++++
 arch/arm/boot/dts/snowball.dts |    4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 92fd4b74..6c25fbe 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -764,5 +764,13 @@
 			v-ape-supply = <&db8500_vape_reg>;
 			status = "disabled";
 		};
+
+		hash at a03c2000 {
+			compatible = "stericsson,ux500-hash";
+			reg = <0xa03c2000 0x1000>;
+
+			v-ape-supply = <&db8500_vape_reg>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index de585fd..3cadb5b 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -354,5 +354,9 @@
 		cryp at a03cb000 {
 			status = "okay";
 		};
+
+		hash at a03c2000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.10.4
