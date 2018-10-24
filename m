From: lsun@mellanox.com (Liming Sun)
Date: Wed, 24 Oct 2018 13:55:33 -0400
Subject: [PATCH v4 3/4] dt-bindings: soc: Add TmFifo binding for Mellanox
 BlueField SoC
In-Reply-To: <1540403734-137721-1-git-send-email-lsun@mellanox.com>
References: <1540403734-137721-1-git-send-email-lsun@mellanox.com>
Message-ID: <1540403734-137721-3-git-send-email-lsun@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree bindings for the TmFifo which is found on Mellanox
BlueField SoCs.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 .../devicetree/bindings/soc/mellanox/tmfifo.txt    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt

diff --git a/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt b/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
new file mode 100644
index 0000000..8a13fa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mellanox/tmfifo.txt
@@ -0,0 +1,23 @@
+* Mellanox BlueField SoC TmFifo
+
+BlueField TmFifo provides a shared FIFO between the target and the
+external host machine, which can be accessed by external host via
+USB or PCIe. In the current tmfifo driver, this FIFO has been demuxed
+to implement virtual console and network interface based on the virtio
+framework.
+
+Required properties:
+
+- compatible:	Should be "mellanox,bf-tmfifo"
+- reg:		Physical base address and length of Rx/Tx block
+- interrupts:	The interrupt number of Rx low water mark, Rx high water mark
+		Tx low water mark, Tx high water mark respectively.
+
+Example:
+
+tmfifo at 800a20 {
+	compatible = "mellanox,bf-tmfifo";
+	reg = <0x00800a20 0x00000018
+	       0x00800a40 0x00000018>;
+	interrupts = <41, 42, 43, 44>;
+};
-- 
1.8.3.1
