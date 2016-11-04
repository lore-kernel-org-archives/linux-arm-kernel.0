From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 05 Nov 2016 01:05:28 +0300
Subject: [PATCH v2 11/11] ARM: dts: sk-rzg1e: add Ether support
In-Reply-To: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
Message-ID: <1633148.RWrrAXQYR6@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the SK-RZG1E board dependent part of the Ether device node.
Enable DHCP and NFS root  for the kernel booting.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- added Geert's tag.

 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
+++ renesas/arch/arm/boot/dts/r8a7745-sk-rzg1e.dts
@@ -20,7 +20,7 @@
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial0:115200n8";
 	};
 
@@ -37,3 +37,16 @@
 &scif2 {
 	status = "okay";
 };
+
+&ether {
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+		interrupt-parent = <&irqc>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
