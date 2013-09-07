From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 7 Sep 2013 04:29:33 +0400
Subject: [PATCH v2 3/4] ARM: shmobile: bockw-reference: add Ether DT support
In-Reply-To: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
Message-ID: <201309070429.34126.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the BOCK-W board dependent part of the Ether device node. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7778-bockw-reference.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ renesas/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -30,3 +30,14 @@
 		reg = <0x60000000 0x10000000>;
 	};
 };
+
+&ether {
+	status = "ok";
+	phy-mode = "rmii";
+	phy-handle = <&phy1>;
+	renesas,no-ether-link;
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
