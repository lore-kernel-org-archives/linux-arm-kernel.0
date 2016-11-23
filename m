From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Nov 2016 21:14:35 +0100
Subject: [PATCH 28/31] ARM: dts: r8a7791: Add device node for PRR
In-Reply-To: <cover.1479931686.git.horms+renesas@verge.net.au>
References: <cover.1479931686.git.horms+renesas@verge.net.au>
Message-ID: <366cd112025838fbbb1be73b7efd7f70bed33b65.1479931687.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 091d7fb6ee7d..4c50de2faef1 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1485,6 +1485,11 @@
 		};
 	};
 
+	prr: chipid at ff000044 {
+		compatible = "renesas,prr";
+		reg = <0 0xff000044 0 4>;
+	};
+
 	sysc: system-controller at e6180000 {
 		compatible = "renesas,r8a7791-sysc";
 		reg = <0 0xe6180000 0 0x0200>;
-- 
2.7.0.rc3.207.g0ac5344
