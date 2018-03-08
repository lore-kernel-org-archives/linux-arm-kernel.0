From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu,  8 Mar 2018 11:11:45 -0800
Subject: [PATCH v5 01/21] nvmem: Document struct nvmem_config
In-Reply-To: <20180308191205.26943-1-andrew.smirnov@gmail.com>
References: <20180308191205.26943-1-andrew.smirnov@gmail.com>
Message-ID: <20180308191205.26943-2-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a simple description of struct nvmem_config and its fields.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy at gmail.com
Cc: linux-kernel at vger.kernel.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 include/linux/nvmem-provider.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 497706f5adca..a39f76ff2ccd 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -22,6 +22,28 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
 				 void *val, size_t bytes);
 
+/**
+ * struct nvmem_config - NVMEM device configuration
+ *
+ * @dev:	Parent device.
+ * @name:	Optional name.
+ * @id:		Optional device ID used in full name. Ignored if name is NULL.
+ * @owner:	Pointer to exporter module. Used for refcounting.
+ * @cells:	Optional array of pre-defined NVMEM cells.
+ * @ncells:	Number of elements in cells.
+ * @read_only:	Device is read-only.
+ * @root_only:	Device is accessibly to root only.
+ * @reg_read:	Callback to read data.
+ * @reg_write:	Callback to write data.
+ * @size:	Device size.
+ * @word_size:	Minimum read/write access granularity.
+ * @stride:	Minimum read/write access stride.
+ * @priv:	User context passed to read/write callbacks.
+ *
+ * Note: A default "nvmem<id>" name will be assigned to the device if
+ * no name is specified in its configuration. In such case "<id>" is
+ * generated with ida_simple_get() and provided id field is ignored.
+ */
 struct nvmem_config {
 	struct device		*dev;
 	const char		*name;
-- 
2.14.3
