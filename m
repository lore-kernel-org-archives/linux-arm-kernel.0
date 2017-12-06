From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:49 +0100
Subject: [PATCH 54/61] ARM: dts: r8a7791: Remove CMT renesas,channels-mask
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <d3fb90537855bb7f27d6256446197675ffb4a1bd.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Update the DTS to remove the now deprecated "renesas,channels-mask"
property.

The channel information is now kept in the device driver and can easily
be determined based on the compat string.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a69d6f883b34..dfc1c406179f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -266,8 +266,6 @@
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		resets = <&cpg 124>;
 
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -287,8 +285,6 @@
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
 		resets = <&cpg 329>;
 
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
-- 
2.11.0
