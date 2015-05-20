From: xander.huff@ni.com (Xander Huff)
Date: Wed, 20 May 2015 10:22:32 -0500
Subject: [PATCH v2 2/2] iio: adc: xilinx-xadc: Add label as an optional
 argument for aux channels
In-Reply-To: <1432135352-29848-1-git-send-email-xander.huff@ni.com>
References: <555B78A3.2030202@metafoo.de>
 <1432135352-29848-1-git-send-email-xander.huff@ni.com>
Message-ID: <1432135352-29848-2-git-send-email-xander.huff@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To better facilitate user-mode access to optional aux channels, allow
device trees to specify a custom label for defined channels.

Signed-off-by: Xander Huff <xander.huff@ni.com>
Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index ce93bd8..bda4241 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1119,6 +1119,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 			if (ret || reg > 16)
 				continue;
 
+			of_property_read_string(child, "label",
+						&chan->extend_name);
+
 			if (of_property_read_bool(child, "xlnx,bipolar"))
 				chan->scan_type.sign = 's';
 
-- 
1.9.1
