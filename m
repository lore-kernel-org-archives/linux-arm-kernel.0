From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 22 Jun 2018 11:49:10 +0800
Subject: [PATCH 7/7] arm64: dts: mt7622: add earlycon to mt7622-rfb1 board
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
Message-ID: <4a8b1000e7d8979b0c6c6f9836296b7dd382f6cd.1529639050.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add earlycon to mt7622-rfb1 as to know what was going on when a certain
fault is happening at the early initialization stage.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 1ff003e..a747b7b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -18,7 +18,7 @@
 	compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
 
 	chosen {
-		bootargs = "console=ttyS0,115200n1 swiotlb=512";
+		bootargs = "earlycon=uart8250,mmio32,0x11002000 console=ttyS0,115200n1 swiotlb=512";
 	};
 
 	cpus {
-- 
2.7.4
