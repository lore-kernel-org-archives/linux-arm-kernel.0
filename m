From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 31 Jul 2017 15:36:39 +0800
Subject: [PATCH v5 06/10] arm: dts: mt7623: cleanup the mt7623n rfb uart nodes
In-Reply-To: <cover.1501486190.git.sean.wang@mediatek.com>
References: <cover.1501486190.git.sean.wang@mediatek.com>
Message-ID: <49854fd2da4b8742a33e3ea6fe6cd2f61fc65103.1501486190.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Crispin <john@phrozen.org>

This patch does a cleanup of the uart nodes in the dts file of the RFB. It
adds aliases, enables 2 more uarts and explicitly sets the uart mode of the
console.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623n-rfb.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index 805ba69..5e0dd79 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -19,7 +19,7 @@
 
 / {
 	chosen {
-		stdout-path = &uart2;
+		stdout-path = "serial2:115200n8";
 	};
 
 	cpus {
@@ -43,6 +43,20 @@
 	memory at 80000000 {
 		reg = <0 0x80000000 0 0x40000000>;
 	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
 };
 
 &uart2 {
-- 
2.7.4
