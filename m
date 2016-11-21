From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 21 Nov 2016 15:57:22 +0800
Subject: [PATCH V9 5/6] stm dummy: Mark dummy_stm_packet() with notrace
In-Reply-To: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
References: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1479715043-6534-6-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_STM_SOURCE_FTRACE is selected, Function trace data can be
writen to sink via STM, all functions that related to writing data
packets to STM should be marked 'notrace' to avoid being traced by
Ftrace, otherwise the program would stall into an endless loop.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/dummy_stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index a86612d..c5f94ca 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/stm.h>
 
-static ssize_t
+static ssize_t notrace
 dummy_stm_packet(struct stm_data *stm_data, unsigned int master,
 		 unsigned int channel, unsigned int packet, unsigned int flags,
 		 unsigned int size, const unsigned char *payload)
-- 
2.7.4
