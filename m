From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:36 +0100
Subject: [PATCH 03/11] ARM: Kirkwood: Switch TWSI1 of 88f6282 to DT clock
 providers
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-4-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Clock Management of kirkwood has moved to DT clock providers.
However, TWSI1 has not yet been done.
This switches TWSI1 of 88f6282 to DT clock providers.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 9ae2004..4ccea21 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -39,6 +39,7 @@
 			#size-cells = <0>;
 			interrupts = <32>;
 			clock-frequency = <100000>;
+			clocks = <&gate_clk 7>;
 			status = "disabled";
 		};
 	};
-- 
1.7.10.4
