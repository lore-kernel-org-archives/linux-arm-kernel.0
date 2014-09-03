From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed,  3 Sep 2014 09:48:21 +0200
Subject: [PATCH v4 02/12] Documentation: bindings: add reset bindings docs for
 Marvell Berlin SoCs
In-Reply-To: <1409730511-16101-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1409730511-16101-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1409730511-16101-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the reset binding documentation to the SoC binding documentation as
the reset driver in Marvell Berlin SoC is part of the chip/system
control registers. This patch adds the required properties to configure
the reset controller.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/marvell,berlin.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
index 904de5781f44..a99eb9eb14c0 100644
--- a/Documentation/devicetree/bindings/arm/marvell,berlin.txt
+++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
@@ -106,11 +106,21 @@ Required subnode-properties:
 - groups: a list of strings describing the group names.
 - function: a string describing the function used to mux the groups.
 
+* Reset controller binding
+
+A reset controller is part of the chip control registers set. The chip control
+node also provides the reset. The register set is not at the same offset between
+Berlin SoCs.
+
+Required property:
+- #reset-cells: must be set to 2
+
 Example:
 
 chip: chip-control at ea0000 {
 	compatible = "marvell,berlin2-chip-ctrl";
 	#clock-cells = <1>;
+	#reset-cells = <2>;
 	reg = <0xea0000 0x400>;
 	clocks = <&refclk>, <&externaldev 0>;
 	clock-names = "refclk", "video_ext0";
-- 
1.9.1
