From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 27 Jul 2015 16:36:42 +0900
Subject: [PATCH] clk: zynq: remove redundant $(CONFIG_ARCH_ZYNQ) in Makefile
Message-ID: <1437982602-26886-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kbuild descends into drivers/clk/zynq/ only when CONFIG_ARCH_ZYNQ
is enabled.  (see drivers/clk/Makefile)

$(CONFIG_ARCH_ZYNQ) in drivers/clk/zynq/Makefile always evaluates
to 'y'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/zynq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynq/Makefile b/drivers/clk/zynq/Makefile
index 156d923..0afc2e7 100644
--- a/drivers/clk/zynq/Makefile
+++ b/drivers/clk/zynq/Makefile
@@ -1,3 +1,3 @@
 # Zynq clock specific Makefile
 
-obj-$(CONFIG_ARCH_ZYNQ)	+= clkc.o pll.o
+obj-y	+= clkc.o pll.o
-- 
1.9.1
