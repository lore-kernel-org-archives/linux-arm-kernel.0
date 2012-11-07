From: horms@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2012 17:50:43 +0900
Subject: [PATCH 14/15] ARM: shmobile: Add DT table of GIC for sh73a0
In-Reply-To: <1352278244-26702-1-git-send-email-horms@verge.net.au>
References: <1352278244-26702-1-git-send-email-horms@verge.net.au>
Message-ID: <1352278244-26702-15-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index b0c55e1..b250e27 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -806,5 +806,14 @@
 				};
 			};
 		};
+
+		intc: interrupt-controller at f0001000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0xf0001000 0x1000>,
+			      <0xf0000100 0x100>;
+		};
 	};
 };
-- 
1.7.10.4
