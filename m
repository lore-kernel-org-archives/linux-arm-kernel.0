From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:50 +0100
Subject: [PATCH 55/61] ARM: dts: r8a7793: Remove CMT renesas,channels-mask
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <5fdbea7147da1ad43b97c43d685b30d0e6b92d0a.1512555546.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7793.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 4a79da3ddbef..a83c2e9c5723 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -257,8 +257,6 @@
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		resets = <&cpg 124>;
 
-		renesas,channels-mask = <0x60>;
-
 		status = "disabled";
 	};
 
@@ -278,8 +276,6 @@
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
 		resets = <&cpg 329>;
 
-		renesas,channels-mask = <0xff>;
-
 		status = "disabled";
 	};
 
-- 
2.11.0
