From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 17 Jan 2018 16:29:48 +0100
Subject: [PATCH 4/6] arm64: zynqmp: Add missing aliases for ep108
In-Reply-To: <cover.1516202975.git.michal.simek@xilinx.com>
References: <cover.1516202975.git.michal.simek@xilinx.com>
Message-ID: <c8af35b4c9fb8954ef3ac26ed1937f2651228f9f.1516202975.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing aliases for gem0/spis and usbs
spi0 alias is allocated for qspi which is out of tree driver now.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index 84fe7057fcb0..67eababceb93 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -21,9 +21,14 @@
 	model = "ZynqMP EP108";
 
 	aliases {
+		ethernet0 = &gem0;
 		mmc0 = &sdhci0;
 		mmc1 = &sdhci1;
 		serial0 = &uart0;
+		spi1 = &spi0;
+		spi2 = &spi1;
+		usb0 = &usb0;
+		usb1 = &usb1;
 	};
 
 	chosen {
-- 
1.9.1
