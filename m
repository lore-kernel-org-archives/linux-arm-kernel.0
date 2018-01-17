From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 16:29:49 +0100
Subject: [PATCH 5/6] arm64: zynqmp: Added OOB timing settings in
 zynqmp-ep108.dts
In-Reply-To: <cover.1516202975.git.michal.simek@xilinx.com>
References: <cover.1516202975.git.michal.simek@xilinx.com>
Message-ID: <22377adc20a2000627fa3b243b5e526dc585f24d.1516202975.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

This patch adds the sata port phy OOB timing values in the sata
device-tree node.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 67eababceb93..22ea2973800c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -84,6 +84,15 @@
 &sata {
 	status = "okay";
 	ceva,broken-gen2;
+	/* SATA Phy OOB timing settings */
+	ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+	ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+	ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+	ceva,p0-retry-params = /bits/ 16 <0x0216 0x7F06>;
+	ceva,p1-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
+	ceva,p1-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
+	ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
+	ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
 };
 
 &sdhci0 {
-- 
1.9.1
