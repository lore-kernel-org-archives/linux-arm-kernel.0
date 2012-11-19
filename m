From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:52:39 +0100
Subject: [PATCH 3/7] clk: mvebu: rename mvebu_clk_gating_init() to
 mvebu_gating_clk_init()
In-Reply-To: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353343963-23034-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with mvebu_core_clk_init() and mvebu_cpu_clk_init(),
rename mvebu_clk_gating_init() to mvebu_gating_clk_init(), so we have
the nice sequence:

	mvebu_core_clk_init();
	mvebu_gating_clk_init();
	mvebu_cpu_clk_init();

in mvebu_clocks_init().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/clk-gating-ctrl.c |    2 +-
 drivers/clk/mvebu/clk-gating-ctrl.h |    2 +-
 drivers/clk/mvebu/clk.c             |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index e640d5c..745a908 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -225,7 +225,7 @@ static const __initdata struct of_device_id clk_gating_match[] = {
 	{ }
 };
 
-void __init mvebu_clk_gating_init(void)
+void __init mvebu_gating_clk_init(void)
 {
 	struct device_node *np;
 
diff --git a/drivers/clk/mvebu/clk-gating-ctrl.h b/drivers/clk/mvebu/clk-gating-ctrl.h
index 20cc4ad..f9cde9b 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.h
+++ b/drivers/clk/mvebu/clk-gating-ctrl.h
@@ -13,6 +13,6 @@
 #ifndef __MVEBU_CLK_GATING_H
 #define __MVEBU_CLK_GATING_H
 
-void __init mvebu_clk_gating_init(void);
+void __init mvebu_gating_clk_init(void);
 
 #endif
diff --git a/drivers/clk/mvebu/clk.c b/drivers/clk/mvebu/clk.c
index e3bc036..855681b 100644
--- a/drivers/clk/mvebu/clk.c
+++ b/drivers/clk/mvebu/clk.c
@@ -22,6 +22,6 @@
 void __init mvebu_clocks_init(void)
 {
 	mvebu_core_clk_init();
-	mvebu_clk_gating_init();
+	mvebu_gating_clk_init();
 	mvebu_cpu_clk_init();
 }
-- 
1.7.9.5
