From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:14:36 +0100
Subject: [PATCH 29/31] ARM: dts: r8a7792: Add device node for PRR
In-Reply-To: <cover.1479931686.git.horms+renesas@verge.net.au>
References: <cover.1479931686.git.horms+renesas@verge.net.au>
Message-ID: <7cbae74e641761ed117a5a8d903b97a9892a2426.1479931687.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index a75e0cd312c5..69789020cf39 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -120,6 +120,11 @@
 				      IRQ_TYPE_LEVEL_LOW)>;
 		};
 
+		prr: chipid at ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a7792-sysc";
 			reg = <0 0xe6180000 0 0x0200>;
-- 
2.7.0.rc3.207.g0ac5344
