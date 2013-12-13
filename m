From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:36 +0900
Subject: [PATCH 62/69] ARM: shmobile: r8a7740: add FSI support via DTSI
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <efcd869b7c5ef0cff5887842afe2c184e509807a.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index b1c2ed9..52255bf 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -208,4 +208,13 @@
 		cap-sdio-irq;
 		status = "disabled";
 	};
+
+	sh_fsi2: sound at fe1f0000 {
+		#sound-dai-cells = <1>;
+		compatible = "renesas,sh_fsi2";
+		reg = <0xfe1f0000 0x400>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 9 0x4>;
+		status = "disabled";
+	};
 };
-- 
1.8.4
