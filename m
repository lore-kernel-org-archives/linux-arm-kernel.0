From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Sat, 12 Aug 2017 00:28:13 +0200
Subject: [PATCH 2/2] arm64: allwinner: pine64: Enable spi0/spi1
In-Reply-To: <20170811222813.1567-1-stefan.bruens@rwth-aachen.de>
References: <20170811222813.1567-1-stefan.bruens@rwth-aachen.de>
Message-ID: <36eb917eabc044878607a8812b8e18f8@rwthex-w2-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two spi channels/controllers are available on the PI-2 resp. Euler
connector, enable both. Contrary to the Pi, the A64 SOC only supports
one chip select, so the second chipselect is not available (though
it can be emulated using gpio chipselect).

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 08cda24ea194..f795d4074a3a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -123,6 +123,14 @@
 	status = "okay";
 };
 
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
 /* On Exp and Euler connectors */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.13.3
