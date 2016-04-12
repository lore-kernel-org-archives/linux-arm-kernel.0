From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Tue, 12 Apr 2016 17:12:59 -0500
Subject: [PATCH 4/6] Documentation: dt: socfpga: Add Arria10 Ethernet binding
In-Reply-To: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
References: <1460499181-23080-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1460499181-23080-5-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Add the device tree bindings needed to support the Altera Ethernet
FIFO buffers on the Arria10 chip.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 .../bindings/arm/altera/socfpga-eccmgr.txt         |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
index 5a6b160..aa1c593 100644
--- a/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
+++ b/Documentation/devicetree/bindings/arm/altera/socfpga-eccmgr.txt
@@ -76,6 +76,18 @@ Required Properties:
 - compatible : Should be "altr,socfpga-a10-ocram-ecc"
 - reg        : Address and size for ECC block registers.
 
+Ethernet FIFO ECC
+Required Properties:
+- compatible : Should be "altr,socfpga-a10-emac0-rx-ecc" for the 1st EMAC
+	Receive	buffer
+	or "altr,socfpga-a10-emac0-tx-ecc" for the 1st EMAC Transmit buffer
+	or "altr,socfpga-a10-emac1-rx-ecc" for the 2nd EMAC Receive buffer
+	or "altr,socfpga-a10-emac1-tx-ecc" for the 2nd EMAC Transmit buffer
+	or "altr,socfpga-a10-emac2-rx-ecc" for the 3rd EMAC Receive buffer
+	or "altr,socfpga-a10-emac2-tx-ecc" for the 3rd EMAC Transmit buffer
+- reg        : Address and size for ECC block registers.
+- parent     : phandle to parent Ethernet node.
+
 Example:
 
 	eccmgr: eccmgr at ffd06000 {
@@ -96,4 +108,16 @@ Example:
 			compatible = "altr,socfpga-a10-ocram-ecc";
 			reg = <0xff8c3000 0x90>;
 		};
+
+		emac0-rx-ecc at ff8c0800 {
+			compatible = "altr,socfpga-a10-emac0-rx-ecc";
+			reg = <0xff8c0800 0x400>;
+			parent = <&gmac0>;
+		};
+
+		emac0-tx-ecc at ff8c0c00 {
+			compatible = "altr,socfpga-a10-emac0-tx-ecc";
+			reg = <0xff8c0c00 0x400>;
+			parent = <&gmac0>;
+		};
 	};
-- 
1.7.9.5
