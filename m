From: xander.huff@ni.com (Xander Huff)
Date: Wed, 20 May 2015 10:22:31 -0500
Subject: [PATCH v2 1/2] devicetree: xilinx-xadc: Add optional label property
In-Reply-To: <555B78A3.2030202@metafoo.de>
References: <555B78A3.2030202@metafoo.de>
Message-ID: <1432135352-29848-1-git-send-email-xander.huff@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To better facilitate user-mode access to optional aux channels, allow
device trees to specify a custom label for defined channels.

Signed-off-by: Xander Huff <xander.huff@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
---
 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
index d71258e..19dcd96 100644
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
@@ -68,6 +68,7 @@ Optional properties:
 			  Note each channel number should only be used at most
 			  once.
 		Optional properties:
+			* label: Custom label for the channel.
 			* xlnx,bipolar: If set the channel is used in bipolar
 			  mode.
 
@@ -107,6 +108,7 @@ Examples:
 			#size-cells = <0>;
 			channel at 0 {
 				reg = <0>;
+				label = "vin_v";
 				xlnx,bipolar;
 			};
 		};
-- 
1.9.1
