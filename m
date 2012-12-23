From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sun, 23 Dec 2012 11:34:35 +0900
Subject: [PATCH 2/4] ARM: Kirkwood: Switch TWSI1 of 88f6282 to DT clock
 providers
In-Reply-To: <1356230077-15340-1-git-send-email-iwamatsu@nigauri.org>
References: <1356230077-15340-1-git-send-email-iwamatsu@nigauri.org>
Message-ID: <1356230077-15340-2-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock Management of kirkwood has moved to DT clock providers.
However, TWSI1 has not yet been done.
This switches TWSI1 of 88f6282 to DT clock providers.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index bc23081..ad63b88 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -45,6 +45,7 @@
 			#size-cells = <0>;
 			interrupts = <32>;
 			clock-frequency = <100000>;
+			clocks = <&gate_clk 7>;
 			status = "disabled";
 		};
 	};
-- 
1.7.10.4
