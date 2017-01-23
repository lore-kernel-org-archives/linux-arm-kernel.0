From: john@phrozen.org (John Crispin)
Date: Mon, 23 Jan 2017 12:29:33 +0100
Subject: [PATCH 14/16] arm: dts: cleanup the mt7623n rfb uart nodes
In-Reply-To: <1485170975-51813-1-git-send-email-john@phrozen.org>
References: <1485170975-51813-1-git-send-email-john@phrozen.org>
Message-ID: <1485170975-51813-15-git-send-email-john@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does a cleanup of the uart nodes in the dts file of the RFB. It
adds aliases, enables 2 more uarts and explicitly sets the uart mode of the
console.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/boot/dts/mt7623n-rfb.dtsi |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index d46390e..df9e564 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -16,12 +16,26 @@
 
 / {
 	chosen {
-		stdout-path = &uart2;
+		stdout-path = "serial2:115200n8";
 	};
 
 	memory {
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
1.7.10.4
