From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 21 May 2018 17:53:46 +0800
Subject: [RFC PATCH xlnx] clk: q0_ns1_options[] can be static
In-Reply-To: <201805211727.w7Yi11Xp%fengguang.wu@intel.com>
References: <201805211727.w7Yi11Xp%fengguang.wu@intel.com>
Message-ID: <20180521095346.GA21243@lkp-sb05>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 6588700bdabc ("clk: Add ccf driver for IDT 8T49N24x UFT")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 clk-idt8t49n24x-core.c    |    2 +-
 clk-idt8t49n24x-debugfs.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/idt/clk-idt8t49n24x-core.c b/drivers/clk/idt/clk-idt8t49n24x-core.c
index fb8f4db..5fce51e 100644
--- a/drivers/clk/idt/clk-idt8t49n24x-core.c
+++ b/drivers/clk/idt/clk-idt8t49n24x-core.c
@@ -47,7 +47,7 @@
 #define IDT24x_VCO_OPT			3500000000u
 #define IDT24x_MIN_INT_DIVIDER		6
 
-u8 q0_ns1_options[3] = { 4, 5, 6 };
+static u8 q0_ns1_options[3] = { 4, 5, 6 };
 
 /**
  * bits_to_shift - num bits to shift given specified mask
diff --git a/drivers/clk/idt/clk-idt8t49n24x-debugfs.c b/drivers/clk/idt/clk-idt8t49n24x-debugfs.c
index d8fcf4e..0b259cb 100644
--- a/drivers/clk/idt/clk-idt8t49n24x-debugfs.c
+++ b/drivers/clk/idt/clk-idt8t49n24x-debugfs.c
@@ -16,7 +16,7 @@
 
 #include "clk-idt8t49n24x-debugfs.h"
 
-struct clk_idt24x_chip *idt24x_chip_fordebugfs;
+static struct clk_idt24x_chip *idt24x_chip_fordebugfs;
 
 static int idt24x_read_all_settings(
 	struct clk_idt24x_chip *chip, char *output_buffer, int count)
