From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 10:13:40 +0530
Subject: [PATCH V3 2/8] clk: add a fixed factor clock
In-Reply-To: <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
Message-ID: <4F9A23FC.6000207@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Having fixed factors/dividers in hardware is a common pattern, so
> add a basic clock type doing this. It basically describes a fixed
> factor clock using a nominator and a denominator.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

    fixup! clk: add a fixed factor clock
---
 drivers/clk/clk-fixed-factor.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 7453efe..9afbdc4 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -49,7 +49,8 @@ static long clk_factor_round_rate(struct clk_hw *hw, unsigned long rate,
        }
 }
 
-static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate)
+static int clk_factor_set_rate(struct clk_hw *hw, unsigned long rate,
+                               unsigned long parent_rate)
 {
        return 0;
 }

-- 
viresh
