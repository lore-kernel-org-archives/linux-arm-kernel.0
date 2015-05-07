From: xander.huff@ni.com (Xander Huff)
Date: Thu, 7 May 2015 17:44:03 -0500
Subject: [PATCH 1/2] devicetree: xilinx-xadc: Add optional xlnx,
 extend-name property
Message-ID: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To better facilitate user-mode access to optional aux channels, allow
device trees to specify a custom extended name for defined channels.

Signed-off-by: Xander Huff <xander.huff@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
--
Natinst-ReviewBoard-ID: 97119
---
 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
index d71258e..4c5a60b 100644
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
@@ -68,6 +68,8 @@ Optional properties:
 			  Note each channel number should only be used at most
 			  once.
 		Optional properties:
+			* xlnx,extend-name: Custom extended name for the
+			  channel.
 			* xlnx,bipolar: If set the channel is used in bipolar
 			  mode.
 
@@ -107,6 +109,7 @@ Examples:
 			#size-cells = <0>;
 			channel at 0 {
 				reg = <0>;
+				xlnx,extend-name = "vin_v";
 				xlnx,bipolar;
 			};
 		};
-- 
1.9.1
