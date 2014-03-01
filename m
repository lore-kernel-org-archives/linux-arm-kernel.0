From: marek@goldelico.com (Marek Belisko)
Date: Sat,  1 Mar 2014 14:58:52 +0100
Subject: [PATCH v2 5/7] ARM: dts: omap3-gta04: Add basic sound support
In-Reply-To: <1393682334-26805-1-git-send-email-marek@goldelico.com>
References: <1393682334-26805-1-git-send-email-marek@goldelico.com>
Message-ID: <1393682334-26805-6-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: NeilBrown <neilb@suse.de>

This adds basic sound support for gta04 board.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 42fc12e..41a21bd 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -36,6 +36,14 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "gta04";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
 };
 
 &omap3_pmx_core {
@@ -80,6 +88,12 @@
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
 	};
+
+	twl_audio: audio {
+		compatible = "ti,twl4030-audio";
+		codec {
+		};
+	};
 };
 
 #include "twl4030.dtsi"
-- 
1.8.3.2
