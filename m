From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:43:58 +0100
Subject: [PATCH 03/12] arm64: dts: r8a7795: salvator-x: Add DU LVDS output
 endpoint
In-Reply-To: <cover.1478251192.git.horms+renesas@verge.net.au>
References: <cover.1478251192.git.horms+renesas@verge.net.au>
Message-ID: <ea3c17b03b9bb57c0ea05a8afac934649128c2f0.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Declaring the endpoint makes LVDS enablement easier by just including
the corresponding panel's dtsi file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index ff4e4fe843ed..c8f6023c4667 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -191,6 +191,10 @@
 				remote-endpoint = <&adv7123_in>;
 			};
 		};
+		port at 3 {
+			lvds_connector: endpoint {
+			};
+		};
 	};
 };
 
-- 
2.7.0.rc3.207.g0ac5344
