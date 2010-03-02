From: viresh.kumar@st.com (Viresh KUMAR)
Date: Tue,  2 Mar 2010 16:35:54 +0530
Subject: [PATCH] CLKDEV: return from clk_find as soon as we get maching clk
Message-ID: <1267527954-20270-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_find function looks for clock with matching dev_id and con_id.
We should return from clk_find as soon as we get a clock with matching dev_id
and con_id. This can be done by comparing variable "match" with 3.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/common/clkdev.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
index aae5bc0..736dfba 100644
--- a/arch/arm/common/clkdev.c
+++ b/arch/arm/common/clkdev.c
@@ -55,6 +55,9 @@ static struct clk *clk_find(const char *dev_id, const char *con_id)
 		if (match == 0)
 			continue;
 
+		if (match == 3)
+			return p->clk;
+
 		if (match > best) {
 			clk = p->clk;
 			best = match;
-- 
1.6.0.2
