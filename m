From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:48 +0100
Subject: [PATCH 47/77] ARM: dts: sun7i: Fix HDMI output DTC warning
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <9668c8faee169042aa5cb6dc06f502c6e9ab275d.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our HDMI output endpoint on the A10s DTSI has a warning under DTC: "graph
node has single child node 'endpoint', #address-cells/#size-cells are not
necessary". Fix this by removing those properties.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bffd3a21bee3..1b247369ec86 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -662,8 +662,6 @@
 				};
 
 				hdmi_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
-- 
git-series 0.9.1
