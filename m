From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 12 Nov 2018 09:28:06 +0800
Subject: [PATCH v1 1/3] arm64: dts: mt7622: fix no more console output on rfb1
Message-ID: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The issue was found by Kernel CI:
https://kernelci.org/boot/id/5bbdcbad59b5146fc5b43592/

Fix this by using a 'stdout-path' property that points to the device.

Fixes: c0d9f9ad4f76 ("arm64: dts: mt7622: add earlycon to mt7622-rfb1 board")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
Changes since v1: revise commit msg
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index dcad086..3f78334 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -17,8 +17,13 @@
 	model = "MediaTek MT7622 RFB1 board";
 	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
 
+	aliases {
+		serial0 = &uart0;
+	};
+
 	chosen {
-		bootargs = "earlycon=uart8250,mmio32,0x11002000 console=ttyS0,115200n1 swiotlb=512";
+		stdout-path = "serial0:115200n8";
+		bootargs = "earlycon=uart8250,mmio32,0x11002000 swiotlb=512";
 	};
 
 	cpus {
-- 
1.9.1
