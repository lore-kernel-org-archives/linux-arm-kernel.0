From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:07 +0900
Subject: [PATCH 33/69] ARM: shmobile: bockw: enable HSPI0 on DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <8c6639665d9771d2e84fe6e0915d46a6fbb8594e.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 9c8bd37..f488c48 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -86,6 +86,11 @@
 				  "sdhi0_cd", "sdhi0_wp";
 		renesas,function = "sdhi0";
 	};
+
+	hspi0_pins: hspi0 {
+		renesas,groups = "hspi0_a";
+		renesas,function = "hspi0";
+	};
 };
 
 &sdhi0 {
@@ -96,3 +101,9 @@
 	bus-width = <4>;
 	status = "okay";
 };
+
+&hspi0 {
+	pinctrl-0 = <&hspi0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.8.4
