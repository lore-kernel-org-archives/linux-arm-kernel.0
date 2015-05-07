From: xander.huff@ni.com (Xander Huff)
Date: Thu, 7 May 2015 17:44:04 -0500
Subject: [PATCH 2/2] iio: adc: xilinx-xadc: Add xlnx,
 extend-name as an optional argument for aux channels
In-Reply-To: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
References: <1431038644-41600-1-git-send-email-xander.huff@ni.com>
Message-ID: <1431038644-41600-2-git-send-email-xander.huff@ni.com>
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
 drivers/iio/adc/xilinx-xadc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index a221f73..cf1d2f9 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1118,6 +1118,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
 			if (ret || reg > 16)
 				continue;
 
+			of_property_read_string(child, "xlnx,extend-name",
+						&chan->extend_name);
+
 			if (of_property_read_bool(child, "xlnx,bipolar"))
 				chan->scan_type.sign = 's';
 
-- 
1.9.1
