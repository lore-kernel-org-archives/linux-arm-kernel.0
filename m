From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 21 Aug 2015 10:26:40 +0200
Subject: [PATCH v3 1/4] regmap: Add missing comments about struct regmap_bus
In-Reply-To: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
References: <1440145603-9612-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1440145603-9612-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some fields of this struct undocumented or old. This patch
updates the missing comments.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/linux/regmap.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 59c55ea0f0b5..73fc34d0c4c2 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -296,8 +296,12 @@ typedef void (*regmap_hw_free_context)(void *context);
  *                if not implemented  on a given device.
  * @async_write: Write operation which completes asynchronously, optional and
  *               must serialise with respect to non-async I/O.
+ * @reg_write: Write a single register value to the given register address. This
+ *             write operation has to complete when returning from the function.
  * @read: Read operation.  Data is returned in the buffer used to transmit
  *         data.
+ * @reg_read: Read a single register value from a given register address.
+ * @free_context: Free context.
  * @async_alloc: Allocate a regmap_async() structure.
  * @read_flag_mask: Mask to be set in the top byte of the register when doing
  *                  a read.
@@ -307,7 +311,6 @@ typedef void (*regmap_hw_free_context)(void *context);
  * @val_format_endian_default: Default endianness for formatted register
  *     values. Used when the regmap_config specifies DEFAULT. If this is
  *     DEFAULT, BIG is assumed.
- * @async_size: Size of struct used for async work.
  */
 struct regmap_bus {
 	bool fast_io;
-- 
2.4.6
