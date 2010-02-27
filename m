From: viresh.kumar@st.com (Viresh KUMAR)
Date: Sat, 27 Feb 2010 14:05:34 +0530
Subject: [PATCH] CLKDEV: remove extra clk_find iterations
Message-ID: <4B88D956.1090003@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/common/clkdev.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

=======================================

diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
index aae5bc0..736dfba 100644

--- a/arch/arm/common/clkdev.c

+++ b/arch/arm/common/clkdev.c

@@ -55,7 +55,10 @@

static?struct?clk?*clk_find(const?char?*dev_id,?const?char?*con_id)
? ? if?(match?==?0)
? ? ? continue;
+? ? if?(match?==?3)
+? ? ? return?p->clk;
+
? ? if?(match?>?best)?{
? ? ? clk?=?p->clk;
? ? ? best?=?match;

-- 1.6.0.2
