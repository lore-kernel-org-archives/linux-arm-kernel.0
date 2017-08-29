From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Tue, 29 Aug 2017 22:26:52 +0200
Subject: [RESEND PATCH 2/2] arm64: allwinner: pine64: Enable spi0/spi1
In-Reply-To: <20170829202652.5476-1-stefan.bruens@rwth-aachen.de>
References: <20170829202652.5476-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170829202652.5476-3-stefan.bruens@rwth-aachen.de>
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
index 827168bc22ed..f25274e8b3e0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -124,6 +124,14 @@
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
2.14.1
