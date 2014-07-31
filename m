From: joel.schopp@amd.com (Joel Schopp)
Date: Thu, 31 Jul 2014 14:43:56 -0500
Subject: [PATCH] arm64: bump MAX_MASTER_STREAMIDS from 16 to 32
Message-ID: <20140731194356.1871.76820.stgit@joelaarch64.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I recently ran into a situation where I needed more than 16 stream ids
for an smmu on an AMD SOC, but we are currently limited to 16 by:

#define MAX_MASTER_STREAMIDS        MAX_PHANDLE_ARGS
#define MAX_PHANDLE_ARGS 16

I expect others will run into this in the future as more advanced SOCs
start to come out. The resulting one line patch has been tested to fix
the problem.

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Joel Schopp <joel.schopp@amd.com>
---
 include/linux/of.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 196b34c..70ad4d9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -67,7 +67,7 @@ struct device_node {
 #endif
 };
 
-#define MAX_PHANDLE_ARGS 16
+#define MAX_PHANDLE_ARGS 32
 struct of_phandle_args {
 	struct device_node *np;
 	int args_count;
