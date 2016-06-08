From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 08 Jun 2016 08:51:53 +0200
Subject: [PATCH] of: reserved_mem: restore old behavior when no region is
 defined
In-Reply-To: <20160607143425.GE1165@e106497-lin.cambridge.arm.com>
References: <20160607143425.GE1165@e106497-lin.cambridge.arm.com>
Message-ID: <1465368713-17866-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change return value back to -ENODEV when no region is defined for given
device. This restores old behavior of this function, as some drivers rely
on such error code.

Reported-by: Liviu Dudau <liviu.dudau@arm.com>
Fixes: 59ce4039727ef40 ("of: reserved_mem: add support for using more than
       one region for given device")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 3cf129f..06af99f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -334,7 +334,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 
 	target = of_parse_phandle(np, "memory-region", idx);
 	if (!target)
-		return -EINVAL;
+		return -ENODEV;
 
 	rmem = __find_rmem(target);
 	of_node_put(target);
-- 
1.9.2
