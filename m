From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 14 Aug 2015 11:17:18 +0100
Subject: [PATCH] nvmem: core: fix a copy paste error
Message-ID: <1439547438-4512-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a copy paste error in a check which is performed to
determine if the cell is specified in bits or not.

This warning was picked-up by a static checker.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 35a42bb..ea0d6fd 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -825,7 +825,7 @@ static int __nvmem_cell_read(struct nvmem_device *nvmem,
 		return rc;
 
 	/* shift bits in-place */
-	if (cell->bit_offset || cell->bit_offset)
+	if (cell->bit_offset || cell->nbits)
 		nvmem_shift_read_buffer_in_place(cell, buf);
 
 	*len = cell->bytes;
-- 
1.9.1
