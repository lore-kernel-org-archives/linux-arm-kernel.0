From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 7 Jun 2016 17:39:25 +0800
Subject: [PATCH 1/1] ARM: dts: imx6qdl.dtsi: add "arm,
 shared-override" for pl310
Message-ID: <1465292365-26038-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6 SMP system has the same DMA memory coherency issue [1] with
pl310 L2 controller. With this shared override bit set, the customer
reports the DMA coherency issue is gone. Besides, I have tested
the performance using USB ethernet with/without this bit, it shows
no difference.

[1] http://patchwork.ozlabs.org/patch/469362/

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ed613eb..30e21ee 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -185,6 +185,7 @@
 			cache-level = <2>;
 			arm,tag-latency = <4 2 3>;
 			arm,data-latency = <4 2 3>;
+			arm,shared-override;
 		};
 
 		pcie: pcie at 0x01000000 {
-- 
1.9.1
