From: josh.cartwright@ni.com (Josh Cartwright)
Date: Wed, 31 Oct 2012 13:45:17 -0600
Subject: [PATCH 3/8] ARM: zynq: dts: add description of the second uart
In-Reply-To: <cover.1351721190.git.josh.cartwright@ni.com>
References: <cover.1351721190.git.josh.cartwright@ni.com>
Message-ID: <8c2fac7167cd7c5201d5e1d8e1ceeb183ee2f63f.1351721190.git.josh.cartwright@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynq-7000 has an additional UART at 0xE0001000.  Describe it in the
device tree.

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/boot/dts/zynq-ep107.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-ep107.dts b/arch/arm/boot/dts/zynq-ep107.dts
index 574bc04..5caf100 100644
--- a/arch/arm/boot/dts/zynq-ep107.dts
+++ b/arch/arm/boot/dts/zynq-ep107.dts
@@ -59,5 +59,12 @@
 			interrupts = <0 27 4>;
 			clock = <50000000>;
 		};
+
+		uart1: uart at e0001000 {
+			compatible = "xlnx,xuartps";
+			reg = <0xE0001000 0x1000>;
+			interrupts = <0 50 4>;
+			clock = <50000000>;
+		};
 	};
 };
-- 
1.8.0
