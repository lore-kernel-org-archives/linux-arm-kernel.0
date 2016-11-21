From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Mon, 21 Nov 2016 15:57:20 +0800
Subject: [PATCH V9 3/6] coresight: Mark stm_generic_packet() with notrace
In-Reply-To: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
References: <1479715043-6534-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1479715043-6534-4-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_STM_SOURCE_FTRACE is selected, Function trace data can be
writen to sink via STM, all functions that related to writing data
packets to STM should be marked 'notrace' to avoid being traced by
Ftrace, otherwise the program would stall into an endless loop.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 49e0f1b..b7543bd 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -406,7 +406,7 @@ static long stm_generic_set_options(struct stm_data *stm_data,
 	return 0;
 }
 
-static ssize_t stm_generic_packet(struct stm_data *stm_data,
+static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 				  unsigned int master,
 				  unsigned int channel,
 				  unsigned int packet,
-- 
2.7.4
