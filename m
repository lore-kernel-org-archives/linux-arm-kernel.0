From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:48 +0100
Subject: [PATCH 31/31] ARM: dts: r8a7794: Add device node for PRR
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <cb74f5808db5105baaf127c51660bbb1a10313c4.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 364b4aa8d1c1..63dc7f29d216 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1377,6 +1377,11 @@
 		};
 	};
 
+	prr: chipid at ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
+
 	sysc: system-controller at e6180000 {
 		compatible = "renesas,r8a7794-sysc";
 		reg = <0 0xe6180000 0 0x0200>;
-- 
2.7.0.rc3.207.g0ac5344
