From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 21:32:50 +0900
Subject: [PATCH 40/43] ARM: mach-shmobile: r8a7779: SATA DT configuration
In-Reply-To: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
References: <1363609973-31086-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363609973-31086-41-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Allow configuration of the r8a7779 SoC SATA controller using a flattened device
tree.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 18383db..fe5c6f2 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -88,4 +88,11 @@
 		compatible = "renesas,rcar-thermal";
 		reg = <0xffc48000 0x38>;
 	};
+
+	sata: sata at fc600000 {
+		compatible = "renesas,rcar-sata";
+		reg = <0xfc600000 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 100 0x4>;
+	};
 };
-- 
1.7.10.4
