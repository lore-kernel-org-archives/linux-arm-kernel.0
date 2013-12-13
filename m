From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:29 +0900
Subject: [PATCH 03/69] ARM: shmobile: lager: add default PFC settings on DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <4a46beadec749d690acecc92811259cd7e85c6c4.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SCIF0/SCIF1 PFC setting is needed as default

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager-reference.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager-reference.dts b/arch/arm/boot/dts/r8a7790-lager-reference.dts
index c462ef1..0a3f0c6 100644
--- a/arch/arm/boot/dts/r8a7790-lager-reference.dts
+++ b/arch/arm/boot/dts/r8a7790-lager-reference.dts
@@ -43,3 +43,18 @@
 		};
 	};
 };
+
+&pfc {
+	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: scif0 {
+		renesas,groups = "scif0_data";
+		renesas,function = "scif0";
+	};
+
+	scif1_pins: scif1 {
+		renesas,groups = "scif1_data";
+		renesas,function = "scif1";
+	};
+};
-- 
1.8.4
