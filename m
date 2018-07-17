From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 18 Jul 2018 02:52:49 +0800
Subject: [RFC PATCH] clk: mediatek: cksys_base can be static
In-Reply-To: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
Message-ID: <20180717185249.GA144124@lkp-hsx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 3cff52bad99d ("clk: mediatek: Add MT6765 clock support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 clk-mt6765.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 7b360b9..2f90511 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -33,8 +33,8 @@
 static DEFINE_SPINLOCK(mt6765_clk_lock);
 
 /* Total 12 subsys */
-void __iomem *cksys_base;
-void __iomem *apmixed_base;
+static void __iomem *cksys_base;
+static void __iomem *apmixed_base;
 
 /* CKSYS */
 #define CLK_SCP_CFG_0		(cksys_base + 0x200)
