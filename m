From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 3 Jul 2014 12:51:22 +0300
Subject: [PATCH 1/2] ARM: DTS: am335x-evm: Enable the McASP FIFO for audio
Message-ID: <1404381083-27029-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of FIFO in McASP can reduce the risk of audio under/overrun and
lowers the load on the memories since the DMA will operate in bursts.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index ecb267767cf5..e2156a583de7 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -529,8 +529,8 @@
 		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
 			0 0 1 2
 		>;
-		tx-num-evt = <1>;
-		rx-num-evt = <1>;
+		tx-num-evt = <32>;
+		rx-num-evt = <32>;
 };
 
 &tps {
-- 
2.0.0
