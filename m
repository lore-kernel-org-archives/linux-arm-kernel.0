From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 3 Jul 2014 12:51:23 +0300
Subject: [PATCH 2/2] ARM: DTS: am335x-evmsk: Enable the McASP FIFO for audio
In-Reply-To: <1404381083-27029-1-git-send-email-peter.ujfalusi@ti.com>
References: <1404381083-27029-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1404381083-27029-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of FIFO in McASP can reduce the risk of audio under/overrun and
lowers the load on the memories since the DMA will operate in bursts.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index ab9a34ce524c..80a3b215e7d6 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -560,8 +560,8 @@
 		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
 			0 0 1 2
 		>;
-		tx-num-evt = <1>;
-		rx-num-evt = <1>;
+		tx-num-evt = <32>;
+		rx-num-evt = <32>;
 };
 
 &tscadc {
-- 
2.0.0
