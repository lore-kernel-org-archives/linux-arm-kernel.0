From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 23 Jan 2013 18:56:52 +0100
Subject: [PATCH 2/2] ARM: dts: omap3-overo: Add audio support
In-Reply-To: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1358963812-19947-3-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed sections to enable audio support on Overo.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/boot/dts/omap3-overo.dtsi |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
index 800be29..81341fa 100644
--- a/arch/arm/boot/dts/omap3-overo.dtsi
+++ b/arch/arm/boot/dts/omap3-overo.dtsi
@@ -23,6 +23,14 @@
 			max-brightness = <127>;
 		};
 	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "overo";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
 };
 
 &i2c1 {
@@ -32,6 +40,12 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
 	};
 };
 
-- 
1.7.5.4
