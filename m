From: baolex.ni@intel.com (Baole Ni)
Date: Tue,  2 Aug 2016 18:52:46 +0800
Subject: [PATCH 0244/1285] Replace numeric parameter like 0444 with macro
Message-ID: <20160802105246.30008-1-baolex.ni@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/i2c/busses/i2c-stu300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 460c134..8128e25 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -133,7 +133,7 @@ enum stu300_error {
 
 /* I2C clock speed, in Hz 0-400kHz*/
 static unsigned int scl_frequency = 100000;
-module_param(scl_frequency, uint,  0644);
+module_param(scl_frequency, uint,  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 /**
  * struct stu300_dev - the stu300 driver state holder
-- 
2.9.2
