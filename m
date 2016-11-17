From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:42 +0100
Subject: [PATCH 25/31] ARM: dts: r8a73a4: Add device node for PRR
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <13c55198b386f6f598ce859a9976c2adecdf88fb.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index ca8672778fe0..53183ffe04c1 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -751,6 +751,11 @@
 		};
 	};
 
+	prr: chipid at ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
+
 	sysc: system-controller at e6180000 {
 		compatible = "renesas,sysc-r8a73a4", "renesas,sysc-rmobile";
 		reg = <0 0xe6180000 0 0x8000>, <0 0xe6188000 0 0x8000>;
-- 
2.7.0.rc3.207.g0ac5344
