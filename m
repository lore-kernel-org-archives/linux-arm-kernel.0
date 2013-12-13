From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:45 +0900
Subject: [PATCH 11/69] ARM: shmobile: r8a7778: add MMCIF support on DTSI
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <f7b901757918a99a52ef3ff281401ee1118fa7f6.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a582211..0ff38e6 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -156,4 +156,12 @@
 		interrupts = <0 77 0x4>;
 		status = "disabled";
 	};
+
+	mmcif: mmcif at ffe4e000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0xffe4e000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 61 4>;
+		status = "disabled";
+	};
 };
-- 
1.8.4
