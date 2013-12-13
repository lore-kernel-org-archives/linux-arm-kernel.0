From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:21 +0900
Subject: [PATCH 47/69] ARM: shmobile: Use r8a7790 suffix for MMCIF compat
 string
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <063e85607ddf26e5ede36b7454eddc8e87544540.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,mmcif-r8a7790" to the compatible string for MMCIF
in case of r8a7790. This makes the MMCIF follow the same style
as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index f844b63..fb9225f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -230,7 +230,7 @@
 	};
 
 	mmcif0: mmcif at ee200000 {
-		compatible = "renesas,sh-mmcif";
+		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
@@ -239,7 +239,7 @@
 	};
 
 	mmcif1: mmc at ee220000 {
-		compatible = "renesas,sh-mmcif";
+		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.4
