From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Sat, 13 Sep 2014 05:00:57 +0800
Subject: [Patch v4 net-next 12/12] ARM: dts: imx6sx: add multi-queue support
 enet
In-Reply-To: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
References: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1410555657-10744-13-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Enable 3 queues suppport for ethernet

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index f4b9da6..0a03260 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -776,6 +776,8 @@
 					 <&clks IMX6SX_CLK_ENET_PTP>;
 				clock-names = "ipg", "ahb", "ptp",
 					      "enet_clk_ref", "enet_out";
+				fsl,num-tx-queues=<3>;
+				fsl,num-rx-queues=<3>;
 				status = "disabled";
                         };
 
-- 
1.9.1
