From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:35 +0200
Subject: [PATCH 073/102] arm64: dts: renesas: salvator-common: add eeprom
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <99b1eb0f62f90159da2c0ff7791f4db9f9c66f64.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Add the EEPROM found on Salvator-X and -XS boards for H3, M3-W, and M3-N
on the IIC_DVFS bus.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 9116f4caa3c6..803220a02f50 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -385,6 +385,12 @@
 			};
 		};
 	};
+
+	eeprom at 50 {
+		compatible = "rohm,br24t01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
 };
 
 &ohci0 {
-- 
2.11.0
