From: joelf@ti.com (Joel Fernandes)
Date: Mon, 30 Sep 2013 10:12:58 -0500
Subject: [PATCH v2 1/9] omap4: dts: Add node for AES
In-Reply-To: <1380553986-15910-1-git-send-email-joelf@ti.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com>
Message-ID: <1380553986-15910-2-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 has an AES module that uses the omap-aes crypto driver.
Add DT entries for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 45708e1..16a44d6 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -663,5 +663,14 @@
 			ram-bits = <12>;
 			ti,has-mailbox;
 		};
+
+		aes: aes at 4b501000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
+			reg = <0x4b501000 0xa0>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&sdma 111>, <&sdma 110>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
1.8.1.2
