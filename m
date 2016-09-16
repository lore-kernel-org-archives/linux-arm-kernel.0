From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 16 Sep 2016 01:52:00 +0000
Subject: [PATCH -next] dma: mv_xor: fix invalid use of sizeof in
 orion_ge00_switch_init()
Message-ID: <1473990720-20605-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

sizeof() when applied to a pointer typed expression gives the
size of the pointer, not that of the pointed data.

Fixes: fe158a17c1e0 ("ARM: orion: simplify orion_ge00_switch_init")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/arm/plat-orion/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 272f49b..23a975a 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -478,7 +478,7 @@ void __init orion_ge00_switch_init(struct dsa_platform_data *d)
 	for (i = 0; i < d->nr_chips; i++)
 		d->chip[i].host_dev = &orion_ge_mvmdio.dev;
 
-	platform_device_register_data(NULL, "dsa", 0, d, sizeof(d));
+	platform_device_register_data(NULL, "dsa", 0, d, sizeof(*d));
 }
 
 /*****************************************************************************
