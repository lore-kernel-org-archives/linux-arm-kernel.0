From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 11 Aug 2015 12:03:36 +0100
Subject: [PATCH RFC 2/3] nvmem: set the size for the nvmem binary file.
In-Reply-To: <1439290931-18232-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439290931-18232-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1439291016-18333-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the actual size of binary file to the nvmem size.
Previously this was not possible as the core was using the static global
data structures for attributes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 103f6aa..414ed23 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -312,6 +312,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 			   config->read_only;
 	nvmem->bin = bin_attr_template;
 	nvmem->bin.attr.mode = nvmem->read_only ? : (S_IRUSR | S_IWUSR);
+	nvmem->bin.size = nvmem->size;
 	device_initialize(&nvmem->dev);
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-- 
1.9.1
