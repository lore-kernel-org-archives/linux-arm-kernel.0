From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:03 +0100
Subject: [PATCH 02/77] ARM: dts: sun4i: Fix HDMI output DTC warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <f94e560d48baed0c5d9932eec1102c1fe76ff29d.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our HDMI output endpoint on the A10 DTSI has a warning under DTC: "graph
node has single child node 'endpoint', #address-cells/#size-cells are not
necessary". Fix this by removing those properties.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 3d62a8950720..5d46bb0139fa 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -530,8 +530,6 @@
 				};
 
 				hdmi_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
-- 
git-series 0.9.1
