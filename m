From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 14 Mar 2017 08:58:29 +0100
Subject: [PATCH 1/2] ARM: dts: BCM5301X: Specify serial console parameters
Message-ID: <20170314075830.2247-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This adds baud rate, parity & number of data bits. It's required to get
serial working correctly.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 8fd1ef9f0c2d..468107166a6f 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -18,8 +18,12 @@
 / {
 	interrupt-parent = <&gic>;
 
+	aliases {
+		serial0 = &uart0;
+	};
+
 	chosen {
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	chipcommonA {
-- 
2.11.0
