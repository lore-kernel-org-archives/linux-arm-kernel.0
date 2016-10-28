From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Oct 2016 18:38:46 -0700
Subject: [PATCH v3 1/3] clk: stm32f4: Add LSI & LSE clocks
In-Reply-To: <1477041810-12313-2-git-send-email-gabriel.fernandez@st.com>
References: <1477041810-12313-1-git-send-email-gabriel.fernandez@st.com>
 <1477041810-12313-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20161028013846.GA16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch introduces the support of the LSI & LSE clocks.
> The clock drivers needs to disable the power domain write protection
> using syscon/regmap to enable these clocks.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---

Applied to clk-next + 

diff --git a/drivers/clk/clk-stm32f4.c b/drivers/clk/clk-stm32f4.c
index c2661e28eeda..5eb05dbf59b8 100644
--- a/drivers/clk/clk-stm32f4.c
+++ b/drivers/clk/clk-stm32f4.c
@@ -224,7 +224,7 @@ static const u64 stm32f46xx_gate_map[MAX_GATE_MAP] = { 0x000000f17ef417ffull,
 						       0x0000000000000003ull,
 						       0x0c777f33f6fec9ffull };
 
-const u64 *stm32f4_gate_map;
+static const u64 *stm32f4_gate_map;
 
 static struct clk_hw **clks;
 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
