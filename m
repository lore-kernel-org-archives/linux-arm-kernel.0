From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 28 Apr 2010 15:34:04 -0400
Subject: [PATCH] [ARM] mmp: update twsi index
Message-ID: <mailman.332.1272457371.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sync twsi index to register index. It's used to avoid typo error.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/mmp2.h |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h
b/arch/arm/mach-mmp/include/mach/mmp2.h
index 459f3be..fec220b 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -39,17 +39,17 @@ static inline int mmp2_add_twsi(int id, struct
i2c_pxa_platform_data *data,
 	int ret;

 	switch (id) {
-	case 0: d = &mmp2_device_twsi1; break;
-	case 1: d = &mmp2_device_twsi2; break;
-	case 2: d = &mmp2_device_twsi3; break;
-	case 3: d = &mmp2_device_twsi4; break;
-	case 4: d = &mmp2_device_twsi5; break;
-	case 5: d = &mmp2_device_twsi6; break;
+	case 1: d = &mmp2_device_twsi1; break;
+	case 2: d = &mmp2_device_twsi2; break;
+	case 3: d = &mmp2_device_twsi3; break;
+	case 4: d = &mmp2_device_twsi4; break;
+	case 5: d = &mmp2_device_twsi5; break;
+	case 6: d = &mmp2_device_twsi6; break;
 	default:
 		return -EINVAL;
 	}

-	ret = i2c_register_board_info(id, info, size);
+	ret = i2c_register_board_info(id - 1, info, size);
 	if (ret)
 		return ret;

-- 
1.5.6.5
