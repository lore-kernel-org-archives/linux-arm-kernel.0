From: mohit.kumar@st.com (Mohit Kumar)
Date: Mon, 10 Feb 2014 14:21:52 +0530
Subject: [PATCH V5 1/8] clk: SPEAr13xx: Fix pcie clock name
In-Reply-To: <cover.1391871170.git.pratyush.anand@st.com>
References: <cover.1391871170.git.pratyush.anand@st.com>
Message-ID: <6e6bc5e96945862e8b6421aade15954fa05270b6.1391871170.git.pratyush.anand@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <pratyush.anand@st.com>

Follow dt clock naming convention for PCIe clocks.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel at list.st.com
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/clk/spear/spear1310_clock.c | 6 +++---
 drivers/clk/spear/spear1340_clock.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 65894f7..4daa597 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -742,19 +742,19 @@ void __init spear1310_clk_init(void __iomem *misc_base, void __iomem *ras_base)
 	clk = clk_register_gate(NULL, "pcie_sata_0_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_0_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie.0");
+	clk_register_clkdev(clk, NULL, "b1000000.pcie");
 	clk_register_clkdev(clk, NULL, "b1000000.ahci");
 
 	clk = clk_register_gate(NULL, "pcie_sata_1_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_1_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie.1");
+	clk_register_clkdev(clk, NULL, "b1800000.pcie");
 	clk_register_clkdev(clk, NULL, "b1800000.ahci");
 
 	clk = clk_register_gate(NULL, "pcie_sata_2_clk", "ahb_clk", 0,
 			SPEAR1310_PERIP1_CLK_ENB, SPEAR1310_PCIE_SATA_2_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie.2");
+	clk_register_clkdev(clk, NULL, "b4000000.pcie");
 	clk_register_clkdev(clk, NULL, "b4000000.ahci");
 
 	clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index fe835c1..5a5c664 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -839,7 +839,7 @@ void __init spear1340_clk_init(void __iomem *misc_base)
 	clk = clk_register_gate(NULL, "pcie_sata_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_PCIE_SATA_CLK_ENB,
 			0, &_lock);
-	clk_register_clkdev(clk, NULL, "dw_pcie");
+	clk_register_clkdev(clk, NULL, "b1000000.pcie");
 	clk_register_clkdev(clk, NULL, "b1000000.ahci");
 
 	clk = clk_register_gate(NULL, "sysram0_clk", "ahb_clk", 0,
-- 
1.8.1.2
