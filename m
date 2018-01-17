From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 15:38:48 +0100
Subject: [PATCH] arm: zynq: Add missing address node name in microzed board
Message-ID: <68e1c62ddf13da96c74847cd4f400251ab18350a.1516199926.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is fixing issue reported by dtc:
arch/arm/boot/dts/zynq-microzed.dtb: Warning (unit_address_vs_reg): Node
/memory has a reg or ranges property, but no unit name

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-microzed.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index f21595c55782..dc43ba34e830 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -24,7 +24,7 @@
 		serial0 = &uart1;
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x40000000>;
 	};
-- 
1.9.1
