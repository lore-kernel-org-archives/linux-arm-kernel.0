From: denis@eukrea.com (Denis Carikli)
Date: Mon, 16 Jun 2014 12:11:19 +0200
Subject: [PATCH v14 05/10] ARM: dts: imx5*,
 imx6*: correct display-timings nodes.
In-Reply-To: <1402913484-25910-1-git-send-email-denis@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
Message-ID: <1402913484-25910-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx-drm driver can't use the de-active and
pixelclk-active display-timings properties yet.

Instead the data-enable and the pixel data clock
polarity are hardcoded in the imx-drm driver.

So theses properties are now set to keep
the same behaviour when imx-drm will start
using them.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v13->v14:
- None
ChangeLog v10->v11:
- imx53-tx53-x03x.dts change was removed because it 
  already had the correct setting.
ChangeLog v9->v10:
- New patch that was splitted out of:
  "staging imx-drm: Use de-active and pixelclk-active
  display-timings."
---
 arch/arm/boot/dts/imx51-babbage.dts       |    2 ++
 arch/arm/boot/dts/imx53-m53evk.dts        |    2 ++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     |    2 ++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     |    2 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi |    2 ++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  |    2 ++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  |    2 ++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi    |    2 ++
 8 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index ee51a10..b64a9e3 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -56,6 +56,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 4b036b4..d03ced7 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -41,6 +41,8 @@
 					vfront-porch = <9>;
 					vsync-len = <3>;
 					vsync-active = <1>;
+					de-active = <1>;
+					pixelclk-active = <0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index d3125f0..7f993d6 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -512,6 +512,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 532347f..e06cf9e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -534,6 +534,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 4c4b175..bcf5178 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -353,6 +353,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..230bbc6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -405,6 +405,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 6df6127..9f6b406 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -353,6 +353,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e446192..3297779 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -494,6 +494,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
-- 
1.7.9.5
