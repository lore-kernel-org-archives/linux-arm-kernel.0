From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:52 +0530
Subject: [PATCH V2 5/7] Clk: SPEAr1340: Update sys clock parent array
In-Reply-To: <cover.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <6255f9164c5c6b879469bd33dd9388fe0b62b1c8.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SYS_CLK have multiple parents and selection of parent depends on sys_clk_ctrl
register bit no. 23:25.
 0XX: pll1_clk
 10X: sys_synth_clk
 110: pll2_clk
 111: pll3_clk

Update sys_clk parent array accordingly (ex. 0:3-pll1_clk)

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/clk/spear/spear1340_clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 2cd5520..f927f90 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -369,8 +369,8 @@ static struct frac_rate_tbl gen_rtbl[] = {
 
 /* clock parents */
 static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
-static const char *sys_parents[] = { "none", "pll1_clk", "none", "none",
-	"sys_syn_clk", "none", "pll2_clk", "pll3_clk", };
+static const char *sys_parents[] = { "pll1_clk", "pll1_clk", "pll1_clk",
+	"pll1_clk", "sys_synth_clk", "sys_synth_clk", "pll2_clk", "pll3_clk", };
 static const char *ahb_parents[] = { "cpu_div3_clk", "amba_syn_clk", };
 static const char *gpt_parents[] = { "osc_24m_clk", "apb_clk", };
 static const char *uart0_parents[] = { "pll5_clk", "osc_24m_clk",
-- 
1.7.2.2
