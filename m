From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 13 Dec 2017 02:20:50 -0500
Subject: [PATCH V8 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
References: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513149653-19451-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a get_match_data() callback as part of the firmware node,
implement the OF specific piece for it.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/of/property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 8ad33a4..f25d363 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -981,10 +981,18 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static void *
+of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
+				const struct device *dev)
+{
+	return (void *)of_device_get_match_data(dev);
+}
+
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
 	.device_is_available = of_fwnode_device_is_available,
+	.device_get_match_data = of_fwnode_device_get_match_data,
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
 	.property_read_string_array = of_fwnode_property_read_string_array,
-- 
1.9.1
