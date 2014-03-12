From: denis@eukrea.com (Denis Carikli)
Date: Wed, 12 Mar 2014 17:31:03 +0100
Subject: [PATCH v10][ 06/10] ARM: dts: imx5*,
 imx6*: correct display-timings nodes.
In-Reply-To: <1394641867-15629-1-git-send-email-denis@eukrea.com>
References: <1394641867-15629-1-git-send-email-denis@eukrea.com>
Message-ID: <1394641867-15629-6-git-send-email-denis@eukrea.com>
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
ChangeLog v9->v10:
- New patch that was splitted out of:
  "staging imx-drm: Use de-active and pixelclk-active
  display-timings."

---
 arch/arm/boot/dts/imx51-babbage.dts       |    2 ++
 arch/arm/boot/dts/imx53-m53evk.dts        |    2 ++
 arch/arm/boot/dts/imx53-tx53-x03x.dts     |    2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi     |    2 ++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi     |    2 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi |    2 ++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi  |    2 ++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi  |    2 ++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi    |    2 ++
 9 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 9e9deb2..4732a00 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -38,6 +38,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index 4646ea9..d6e1046 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -40,6 +40,8 @@
 					vfront-porch = <9>;
 					vsync-len = <3>;
 					vsync-active = <1>;
+					de-active = <1>;
+					pixelclk-active = <0>;
 				};
 			};
 		};
diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0217dde3..4092a81 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -93,7 +93,7 @@
 					hsync-active = <0>;
 					vsync-active = <0>;
 					de-active = <1>;
-					pixelclk-active = <1>;
+					pixelclk-active = <0>;
 				};
 
 				ET0500 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index c8e5ae0..43f48f2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -494,6 +494,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 2795dfc..59ecfd1 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -516,6 +516,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 99be301..e9419a2 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -349,6 +349,8 @@
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
index 3bec128..ed4c72f 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -349,6 +349,8 @@
 				vfront-porch = <7>;
 				hsync-len = <60>;
 				vsync-len = <10>;
+				de-active = <1>;
+				pixelclk-active = <0>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 7a88d9a..7d1c84c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -463,6 +463,8 @@
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
