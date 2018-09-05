From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Wed, 5 Sep 2018 12:54:47 +0530
Subject: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga
 driver
In-Reply-To: <20180905072448.12488-1-nava.manne@xilinx.com>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
Message-ID: <20180905072448.12488-3-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Moved pcap node as a child to firwmare
                 node as suggested by Rob.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9bbe44..ef0c3978e6e7 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -16,6 +16,16 @@ Required properties:
 		Permitted values are:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
+--------------------------------------------------------------------------
+Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
+using ZynqMP SoC firmware interface
+--------------------------------------------------------------------------
+For Bitstream configuration on ZynqMp Soc uses processor configuration
+port(PCAP) to configure the programmable logic(PL) through PS by using
+FW interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
 
 -------
 Example
@@ -25,5 +35,8 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_pcap: pcap {
+			compatible = "xlnx,zynqmp-pcap-fpga";
+		};
 	};
 };
-- 
2.18.0
