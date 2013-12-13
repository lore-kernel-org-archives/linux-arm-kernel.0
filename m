From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:46 +0900
Subject: [PATCH 12/69] ARM: shmobile: bockw: add MMCIF support on DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <14cdd83a6df84849c369b201ce248e0213d735e0.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 3c1d1f0..c6b834f 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -50,6 +50,21 @@
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
 	};
+
+	mmc_pins: mmc {
+		renesas,groups = "mmc_data8", "mmc_ctrl";
+		renesas,function = "mmc";
+	};
+};
+
+&mmcif {
+	pinctrl-0 = <&mmc_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <8>;
+	broken-cd;
+	status = "okay";
 };
 
 &irqpin {
-- 
1.8.4
