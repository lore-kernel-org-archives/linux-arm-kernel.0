From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:10:10 +0100
Subject: [PATCH 13/19] ARM: dts: tegra: replace legacy *,
 wakeup property with wakeup-source
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1445422216-29375-14-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though the keyboard and other driver will continue to support the legacy
"gpio-key,wakeup", "nvidia,wakeup-source" boolean property to enable the
wakeup source, "wakeup-source" is the new standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-tegra at vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts        | 2 +-
 arch/arm/boot/dts/tegra114-roth.dts           | 2 +-
 arch/arm/boot/dts/tegra114-tn7.dts            | 2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     | 2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi          | 4 ++--
 arch/arm/boot/dts/tegra124-venice2.dts        | 2 +-
 arch/arm/boot/dts/tegra20-harmony.dts         | 2 +-
 arch/arm/boot/dts/tegra20-paz00.dts           | 2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts        | 4 ++--
 arch/arm/boot/dts/tegra20-trimslice.dts       | 2 +-
 arch/arm/boot/dts/tegra20-ventana.dts         | 2 +-
 arch/arm/boot/dts/tegra20-whistler.dts        | 2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts     | 2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi         | 2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 2 +-
 15 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 8b7aa0dcdc6e..40b88051ea3e 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1164,7 +1164,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		volume_down {
diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index 38acf78d7815..9d868af97b8e 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -1047,7 +1047,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra114-tn7.dts b/arch/arm/boot/dts/tegra114-tn7.dts
index f91c2c9b2f94..89047edb5c5f 100644
--- a/arch/arm/boot/dts/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/tegra114-tn7.dts
@@ -292,7 +292,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		volume_down {
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 66b4451eb2ca..067190532f78 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1761,7 +1761,7 @@
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index a9aec23e06f2..c7af943478b1 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -496,7 +496,7 @@
 			linux,input-type = <5>;
 			linux,code = <KEY_RESERVED>;
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		power {
@@ -504,7 +504,7 @@
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <30>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index cfbdf429b45d..4a5f23c5d893 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -975,7 +975,7 @@
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index b926a07b9443..679f9c49e9f4 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -655,7 +655,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index ed7e1009326c..fce397e3e2ce 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -521,7 +521,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(J, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index aea8994b35f2..a112a415ecd5 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -807,7 +807,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		lid {
@@ -816,7 +816,7 @@
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index d99af4ef9c64..a4aaff326f99 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -392,7 +392,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(X, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 04c58e9ca490..b205935a1236 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -601,7 +601,7 @@
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index 340d81108df1..5564d6e975d8 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -508,7 +508,7 @@
 		nvidia,repeat-delay-ms = <160>;
 		nvidia,kbc-row-pins = <0 1 2>;
 		nvidia,kbc-col-pins = <16 17>;
-		nvidia,wakeup-source;
+		wakeup-source;
 		linux,keymap = <MATRIX_KEY(0x00, 0x00, KEY_POWER)
 				MATRIX_KEY(0x01, 0x00, KEY_HOME)
 				MATRIX_KEY(0x01, 0x01, KEY_BACK)
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 6236bdecb48b..63f781d63520 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -191,7 +191,7 @@
 			gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index bb1ca158273c..1714e755c3de 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -626,7 +626,7 @@
 			interrupts = <2 0>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <100>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 
 		volume-down {
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 4d3ddc585641..96aae2dd38e0 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -141,7 +141,7 @@
 			gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
 			debounce-interval = <10>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 
-- 
1.9.1
