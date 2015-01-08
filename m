From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu,  8 Jan 2015 12:03:44 +0100
Subject: [PATCH v2 2/2] ARM: mediatek: dts: Add uart to Aquaris5
In-Reply-To: <1420715024-27738-1-git-send-email-matthias.bgg@gmail.com>
References: <1420715024-27738-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1420715024-27738-3-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables uart port for the Aquaris5 mobile phone.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/mt6589-aquaris5.dts | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt6589-aquaris5.dts b/arch/arm/boot/dts/mt6589-aquaris5.dts
index 0da0470..594a6f3 100644
--- a/arch/arm/boot/dts/mt6589-aquaris5.dts
+++ b/arch/arm/boot/dts/mt6589-aquaris5.dts
@@ -21,10 +21,20 @@
 	compatible = "mundoreader,bq-aquaris5", "mediatek,mt6589";
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "console=ttyS0,921600n8 earlyprintk";
+		stdout-path = &uart0;
 	};
 
 	memory {
 		reg = <0x80000000 0x40000000>;
 	};
+
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
 };
-- 
1.9.1
