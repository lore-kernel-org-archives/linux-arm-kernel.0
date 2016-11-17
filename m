From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:11:43 +0100
Subject: [PATCH 26/31] ARM: dts: r8a7779: Add device node for PRR
In-Reply-To: <cover.1479391750.git.horms+renesas@verge.net.au>
References: <cover.1479391750.git.horms+renesas@verge.net.au>
Message-ID: <41462d49565f4fb0a18820a75916c5ec9745ed28.1479391750.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 3005308a1807..9d3bb74bd3f6 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -590,6 +590,11 @@
 		};
 	};
 
+	prr: chipid at ff000044 {
+		compatible = "renesas,prr";
+		reg = <0xff000044 4>;
+	};
+
 	sysc: system-controller at ffd85000 {
 		compatible = "renesas,r8a7779-sysc";
 		reg = <0xffd85000 0x0200>;
-- 
2.7.0.rc3.207.g0ac5344
