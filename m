From: yizhouzhou@ict.ac.cn (yizhouzhou at ict.ac.cn)
Date: Wed, 10 Aug 2016 16:08:22 +0800
Subject: [PATCH 1/1] xilinx: check return value of class_create
Message-ID: <1470816502-16802-1-git-send-email-yizhouzhou@ict.ac.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhouyi Zhou <yizhouzhou@ict.ac.cn>

	 return value of class_create should be considered in
module init function.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index c07dfe5..3877b46 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -854,6 +854,9 @@ static int __init hwicap_module_init(void)
 	int retval;
 
 	icap_class = class_create(THIS_MODULE, "xilinx_config");
+	if (IS_ERR(icap_class))
+		return PTR_ERR(icap_class);
+
 	mutex_init(&icap_sem);
 
 	devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR);
-- 
1.9.1
