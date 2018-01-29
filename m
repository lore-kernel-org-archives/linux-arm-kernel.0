From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 29 Jan 2018 10:19:01 +0100
Subject: [linux-sunxi][PATCH v2 3/5] arm64: allwinner: a64: Add SPDIF to the
 Pine64
In-Reply-To: <20180129091903.12319-1-codekipper@gmail.com>
References: <20180129091903.12319-1-codekipper@gmail.com>
Message-ID: <20180129091903.12319-4-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The S/PDIF transmitter can be reached on the Euler connector.
But as this is a GPIO then leave it disabled so that an overlay
can override the status property.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 604cdaedac38..d1161069af9e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -230,6 +230,11 @@
 	regulator-name = "vcc-rtc";
 };
 
+/* On Euler connector */
+&spdif {
+	status = "disabled";
+};
+
 /* On Exp and Euler connectors */
 &uart0 {
 	pinctrl-names = "default";
-- 
2.16.1
