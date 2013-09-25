From: joelf@ti.com (Joel Fernandes)
Date: Wed, 25 Sep 2013 17:01:01 -0500
Subject: [PATCH 1/9] omap4: dts: Add node for AES
In-Reply-To: <1380146469-29496-1-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Message-ID: <1380146469-29496-2-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 has an AES module that uses the omap-aes crypto driver.
Add DT entries for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 45708e1..4267a74 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -663,5 +663,15 @@
 			ram-bits = <12>;
 			ti,has-mailbox;
 		};
+
+		aes: aes at 4B501000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
+			reg = <0x4B501000 0xa0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 85 0x4>;
+			dmas = <&sdma 111>, <&sdma 110>;
+			dma-names = "tx", "rx";
+		};
 	};
 };
-- 
1.8.1.2
