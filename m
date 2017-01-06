From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Jan 2017 12:18:12 +0100
Subject: [PATCH 03/25] ARM: dts: r8a7743: Add device node for PRR
In-Reply-To: <cover.1483700969.git.horms+renesas@verge.net.au>
References: <cover.1483700969.git.horms+renesas@verge.net.au>
Message-ID: <11d4407e939e74e89a29df88b1557b59ece9e9f9.1483700969.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index ca0cda28a3eb..0956125597fd 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -102,6 +102,11 @@
 			#power-domain-cells = <0>;
 		};
 
+		prr: chipid at ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
 		rst: reset-controller at e6160000 {
 			compatible = "renesas,r8a7743-rst";
 			reg = <0 0xe6160000 0 0x100>;
-- 
2.7.0.rc3.207.g0ac5344
