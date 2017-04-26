From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 26 Apr 2017 17:26:10 +0800
Subject: [PATCH v2 26/30] arm: dts: mt7623: cleanup the mt7623n rfb uart nodes
In-Reply-To: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
References: <1493198774-4478-1-git-send-email-sean.wang@mediatek.com>
Message-ID: <1493198774-4478-27-git-send-email-sean.wang@mediatek.com>
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
index c526116..4963e6a 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -16,12 +16,26 @@
 
 / {
 	chosen {
-		stdout-path = &uart2;
+		stdout-path = "serial2:115200n8";
 	};
 
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
1.9.1
