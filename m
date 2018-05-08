From: robh@kernel.org (Rob Herring)
Date: Tue,  8 May 2018 08:59:30 -0500
Subject: [PATCH] arm: dts: omap: fix OMAP3 CM-T3x OF graph video connectors
In-Reply-To: <20180508135930.5768-1-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
Message-ID: <20180508135930.5768-6-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP3 CM-T3x based boards define 2 /connector nodes for S-Video and
DVI output. However, since they have the same node name, the S-Video
connector overwritten. This leaves a dangling graph connection which
gives the following warning:

arch/arm/boot/dts/omap3-sbc-t3517.dtb: Warning (graph_endpoint): /ocp at 68000000/dss at 48050000/encoder at 48050c00/port/endpoint: graph connection to node '/connector/port/endpoint' is not bidirectional

Fix this by renaming the nodes to s-video-connector and dvi-connector.

Cc: "Beno?t Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/omap3-cm-t3x.dtsi | 2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index 9dcb18d22cde..cdb632df152a 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -60,7 +60,7 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	tv0: connector {
+	tv0: svideo-connector {
 		compatible = "svideo-connector";
 		label = "tv";
 
diff --git a/arch/arm/boot/dts/omap3-sb-t35.dtsi b/arch/arm/boot/dts/omap3-sb-t35.dtsi
index 22b4c8bdcc65..fb9842fa922c 100644
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -34,7 +34,7 @@
 		};
 	};
 
-	dvi0: connector {
+	dvi0: dvi-connector {
 		compatible = "dvi-connector";
 		label = "dvi";
 
-- 
2.17.0
