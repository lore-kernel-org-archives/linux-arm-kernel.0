From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:15 +0100
Subject: [PATCH 04/20] coresight: Cleanup platform description data
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nobody uses the "clk" field in struct coresight_platform_data.
Remove it.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/coresight.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index e5421b8..69a5c9f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -87,7 +87,6 @@ struct coresight_dev_subtype {
  * @child_ports:child component port number the current component is
 		connected  to.
  * @nr_outport:	number of output ports for this component.
- * @clk:	The clock this component is associated to.
  */
 struct coresight_platform_data {
 	int cpu;
@@ -97,7 +96,6 @@ struct coresight_platform_data {
 	const char **child_names;
 	int *child_ports;
 	int nr_outport;
-	struct clk *clk;
 };
 
 /**
-- 
2.7.4
