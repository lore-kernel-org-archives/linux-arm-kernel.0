From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Wed, 28 Oct 2015 15:50:47 -0700
Subject: [PATCH V5 2/9] device property: Introducing enum dev_dma_attr
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1446072654-5608-3-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A device could have one of the following DMA attributes:
    * DMA not supported
    * DMA non-coherent
    * DMA coherent

So, this patch introduces enum dev_dma_attribute. This will be used by
new APIs introduced in later patches.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/property.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 463de52..8eecf20 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -27,6 +27,12 @@ enum dev_prop_type {
 	DEV_PROP_MAX,
 };
 
+enum dev_dma_attr {
+	DEV_DMA_NOT_SUPPORTED,
+	DEV_DMA_NON_COHERENT,
+	DEV_DMA_COHERENT,
+};
+
 bool device_property_present(struct device *dev, const char *propname);
 int device_property_read_u8_array(struct device *dev, const char *propname,
 				  u8 *val, size_t nval);
-- 
2.1.0
