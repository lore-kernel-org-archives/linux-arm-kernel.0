From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 2 May 2014 02:56:33 +0400
Subject: [PATCH] ARM: shmobile: henninger: specify EXTAL frequency
Message-ID: <201405020256.34093.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When creating the initial device tree for the Henninger board,  I've overlooked
that EXTAL frequency needs to be overridden there. The 'sh-sci' driver  managed
to work somehow but the SDHI driver that I've tried to enable just hanged with
the default EXTAL frequency of 0...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-v3.15-rc3-20140429' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-henninger.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -35,6 +35,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
 &pfc {
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
