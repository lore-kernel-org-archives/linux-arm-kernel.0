From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 May 2010 20:18:56 -0600
Subject: [PATCH 16/22] OMAP4 clock: Support clk_set_parent
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Message-ID: <20100519021855.19716.35361.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

Remove the hack put in place while clock framework was still not in
place for OMAP4.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/clock.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index c9cd98a..7190cbd 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -138,11 +138,6 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (cpu_is_omap44xx()) {
-		WARN(1, "clock: %s: not supported yet on OMAP4\n", __func__);
-		return 0;
-	}
-
 	if (clk == NULL || IS_ERR(clk) || parent == NULL || IS_ERR(parent))
 		return ret;
 
