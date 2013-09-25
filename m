From: joelf@ti.com (Joel Fernandes)
Date: Wed, 25 Sep 2013 17:01:06 -0500
Subject: [PATCH 6/9] ARM: am437x: dts: Add AES node for am437x
In-Reply-To: <1380146469-29496-1-git-send-email-joelf@ti.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com>
Message-ID: <1380146469-29496-7-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x SoC has AES module similar to the one on OMAP4.
Add DT node for the same.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0fe393a..3e631ab 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -411,5 +411,13 @@
 			ti,hwmods = "epwmss5";
 			status = "disabled";
 		};
+
+		aes: aes at 53501000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes";
+			reg = <0x53501000 0xa0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 103 0x4>;
+		};
 	};
 };
-- 
1.8.1.2
