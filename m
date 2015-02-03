From: rjui@broadcom.com (Ray Jui)
Date: Tue, 3 Feb 2015 10:33:08 -0800
Subject: [PATCH v4 3/5] clk: Change bcm clocks build dependency
In-Reply-To: <1422988390-24369-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1422988390-24369-1-git-send-email-rjui@broadcom.com>
Message-ID: <1422988390-24369-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock code under drivers/clk/bcm now contains code for both the
Broadcom mobile SoCs and the iProc SoCs. Change the the makefile
dependency to be under config flag CONFIG_ARCH_BCM that's enabled for
both families of SoCs

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 drivers/clk/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..eff0213 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_ARCH_VT8500)		+= clk-vt8500.o
 obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
-obj-$(CONFIG_ARCH_BCM_MOBILE)		+= bcm/
+obj-$(CONFIG_ARCH_BCM)			+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
 obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
-- 
1.7.9.5
