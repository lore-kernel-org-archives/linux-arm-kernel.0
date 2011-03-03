From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 Mar 2011 15:47:15 +0530
Subject: [PATCH V2 02/13] dw_dmac: Replace module_init() with subsys_initcall()
In-Reply-To: <cover.1299146382.git.viresh.kumar@st.com>
References: <cover.1299146382.git.viresh.kumar@st.com>
Message-ID: <28e0a75c609f8ab901824f95704600ec29eb8548.1299146382.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases users of dw_dmac are initialized before dw_dmac, and if they try
to use dw_dmac, they simply fail. So its better we register init() routine
of driver using subsys_initcall() instead of module_init(), so that dma driver
is available at the earliest possible.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/dma/dw_dmac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/dw_dmac.c b/drivers/dma/dw_dmac.c
index 08dab3b..064a183 100644
--- a/drivers/dma/dw_dmac.c
+++ b/drivers/dma/dw_dmac.c
@@ -1455,7 +1455,7 @@ static int __init dw_init(void)
 {
 	return platform_driver_probe(&dw_driver, dw_probe);
 }
-module_init(dw_init);
+subsys_initcall(dw_init);
 
 static void __exit dw_exit(void)
 {
-- 
1.7.2.2
