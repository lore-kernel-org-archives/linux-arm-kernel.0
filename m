From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Sat, 13 Sep 2014 05:00:56 +0800
Subject: [Patch v4 net-next 11/12] ARM: Documentation: Update fec dts binding
 doc
In-Reply-To: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
References: <1410555657-10744-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1410555657-10744-12-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

    This patch update fec devicetree binding doc that add Optional
    properties "fsl,num-tx-queues" and "fsl,num-rx-queues".

Signed-off-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 Documentation/devicetree/bindings/net/fsl-fec.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index 8a2c7b5..0c8775c 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -16,6 +16,12 @@ Optional properties:
 - phy-handle : phandle to the PHY device connected to this device.
 - fixed-link : Assume a fixed link. See fixed-link.txt in the same directory.
   Use instead of phy-handle.
+- fsl,num-tx-queues : The property is valid for enet-avb IP, which supports
+  hw multi queues. Should specify the tx queue number, otherwise set tx queue
+  number to 1.
+- fsl,num-rx-queues : The property is valid for enet-avb IP, which supports
+  hw multi queues. Should specify the rx queue number, otherwise set rx queue
+  number to 1.
 
 Optional subnodes:
 - mdio : specifies the mdio bus in the FEC, used as a container for phy nodes
-- 
1.9.1
