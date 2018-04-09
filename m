From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 9 Apr 2018 22:37:49 +0800
Subject: [PATCH v5 7/7] clk: meson: drop CLK_IGNORE_UNUSED flag
In-Reply-To: <20180409143749.71197-1-yixun.lan@amlogic.com>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
Message-ID: <20180409143749.71197-8-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rely on drivers to request the clock explicitly.

Previous the kernel will leave the clock on while
bootloader adready initilized the clock, this wasn't
optimal way, so fix it here.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/axg-aoclk.c  | 1 -
 drivers/clk/meson/gxbb-aoclk.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/clk/meson/axg-aoclk.c b/drivers/clk/meson/axg-aoclk.c
index cb56d809d3df..8457b64b9b7c 100644
--- a/drivers/clk/meson/axg-aoclk.c
+++ b/drivers/clk/meson/axg-aoclk.c
@@ -27,7 +27,6 @@ static struct clk_regmap _name##_ao = {					\
 		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index b3c90a17c0e0..2327eb609fbe 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -70,7 +70,6 @@ static struct clk_regmap _name##_ao = {					\
 		.ops = &clk_regmap_gate_ops,				\
 		.parent_names = (const char *[]){ "clk81" },		\
 		.num_parents = 1,					\
-		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 
-- 
2.15.1
