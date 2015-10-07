From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  7 Oct 2015 12:00:55 +0100
Subject: [PATCH v2 2/3] nvmem: core: set the size for the nvmem binary file.
In-Reply-To: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1444215655-10878-1-git-send-email-srinivas.kandagatla@linaro.org>
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
index 0a70e31..737fa75 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -315,6 +315,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem->read_only)
 		nvmem->bin.attr.mode |= S_IWUSR;
 
+	nvmem->bin.size = nvmem->size;
 	device_initialize(&nvmem->dev);
 
 	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-- 
1.9.1
