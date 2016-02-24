From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:14:24 +0100
Subject: [PATCH v2 4/6] clk: unconditionally recurse into clk/mvebu/
In-Reply-To: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456326866-30854-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1456326866-30854-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drivers/clk/mvebu directory is only being built when
CONFIG_PLAT_ORION=y. As we are going to support additional mvebu
platforms in drivers/clk/mvebu, which don't have CONFIG_PLAT_ORION=y,
we need to recurse into this directory regardless of the value of
CONFIG_PLAT_ORION.

Since all files in drivers/clk/mvebu/ are already conditionally
compiled depending on various Kconfig options, we can recurse
unconditionally into drivers/clk/mvebu without any other change.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b038e36..e08bb0e 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -61,7 +61,7 @@ obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
-obj-$(CONFIG_PLAT_ORION)		+= mvebu/
+obj-y					+= mvebu/
 obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
 obj-$(CONFIG_MACH_PISTACHIO)		+= pistachio/
-- 
2.6.4
