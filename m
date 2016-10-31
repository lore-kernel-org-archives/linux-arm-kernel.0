From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 31 Oct 2016 23:00:03 +0300
Subject: [PATCH v6 7/7] ARM: dts: sk-rzg1m: add Ether support
In-Reply-To: <1746536.qobnGdHRfV@wasted.cogentembedded.com>
References: <1746536.qobnGdHRfV@wasted.cogentembedded.com>
Message-ID: <28982973.nmFCQ433OD@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the SK-RZG1M board dependent part of the Ether device node.
Enable DHCP and NFS root  for the kernel booting.

Based on the original (and large) patch by Dmitry Shifrin
<dmitry.shifrin@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 4:
- added Geert's tag.

Changes in version 2:
- new patch.

 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Index: renesas/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
+++ renesas/arch/arm/boot/dts/r8a7743-sk-rzg1m.dts
@@ -20,7 +20,7 @@
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = "serial0:115200n8";
 	};
 
@@ -42,3 +42,16 @@
 &scif0 {
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
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
