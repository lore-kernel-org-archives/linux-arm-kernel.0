From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 7 Mar 2016 17:17:31 +0200
Subject: [PATCH v2 04/10] ARM: DTS: dra7-evm: Enable AFIFO use for McASP3
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1457363857-20797-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we switched to use eDMA we can now safely enable the FIFO in McASP.
This will reduce the chance of McASP level under/overflow.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index d9b87236019d..1b2a2f8c38e7 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -904,6 +904,8 @@
 	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
 		1 2 0 0
 	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
 };
 
 &mailbox5 {
-- 
2.7.2
