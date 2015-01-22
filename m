From: marek@goldelico.com (Marek Belisko)
Date: Thu, 22 Jan 2015 21:38:08 +0100
Subject: [PATCH 02/13] ARM: dts: omap3-gta04: Fix audio node malformatting
In-Reply-To: <1421959099-28319-1-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
Message-ID: <1421959099-28319-3-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Audio should be child of twl node.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fa39232..c78380e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -202,11 +202,11 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
-	};
 
-	twl_audio: audio {
-		compatible = "ti,twl4030-audio";
-		codec {
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
 		};
 	};
 };
-- 
1.9.1
