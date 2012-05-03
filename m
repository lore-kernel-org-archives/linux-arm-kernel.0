From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 11:13:40 +0530
Subject: [PATCH V3 6/8] SPEAr: clk: Add General Purpose Timer Synthesizer
 clock
In-Reply-To: <91fe5296600bd8ca55f9b7e0a1fd32e1a072f817.1335249846.git.viresh.kumar@st.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <91fe5296600bd8ca55f9b7e0a1fd32e1a072f817.1335249846.git.viresh.kumar@st.com>
Message-ID: <4FA21B0C.8050209@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 12:20 PM, Viresh KUMAR wrote:
> All SPEAr SoC's contain GPT Synthesizers. Their Fout is derived from
> following equations:
> 
> Fout= Fin/((2 ^ (N+1)) * (M+1))
> 
> This patch adds in support for this type of clock.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Another Fixup:

---
 drivers/clk/spear/clk-gpt-synth.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/clk-gpt-synth.c b/drivers/clk/spear/clk-gpt-synth.c
index f3b252a..688cbf4 100644
--- a/drivers/clk/spear/clk-gpt-synth.c
+++ b/drivers/clk/spear/clk-gpt-synth.c
@@ -46,10 +46,9 @@ static long clk_gpt_round_rate(struct clk_hw *hw, unsigned long drate,
                unsigned long *prate)
 {
        struct clk_gpt *gpt = to_clk_gpt(hw);
-       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
        int unused;
 
-       return clk_round_rate_index(hw, drate, parent_rate, gpt_calc_rate,
+       return clk_round_rate_index(hw, drate, *prate, gpt_calc_rate,
                        gpt->rtbl_cnt, &unused);
 }

-- 
viresh
