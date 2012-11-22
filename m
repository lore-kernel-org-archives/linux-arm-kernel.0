From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 22 Nov 2012 17:00:11 +0900
Subject: [PATCH v5 14/15] ARM: shmobile: Add DT table of GIC for sh73a0
In-Reply-To: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <1353571213-26006-15-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Horman <horms@verge.net.au>

Cc: Magnus Damm <damm@opensource.se>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 5348994..40d1dfe 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -808,5 +808,14 @@
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
