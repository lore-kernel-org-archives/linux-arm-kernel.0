From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:29 -0700
Subject: [PATCH 8/9] [ARM] tegra: common: Update common clock init table
In-Reply-To: <1280449771-24043-1-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
Message-ID: <1280449771-24043-9-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

Renames clocks in the clock init table to match the datasheet names

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 9aedaf7..445104a 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -36,8 +36,8 @@ static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
 	{ "pll_p_out2",	"pll_p",	48000000,	true },
 	{ "pll_p_out3",	"pll_p",	72000000,	true },
 	{ "pll_p_out4",	"pll_p",	108000000,	true },
-	{ "sys",	"pll_p_out4",	108000000,	true },
-	{ "hclk",	"sys",		108000000,	true },
+	{ "sclk",	"pll_p_out4",	108000000,	true },
+	{ "hclk",	"sclk",		108000000,	true },
 	{ "pclk",	"hclk",		54000000,	true },
 	{ NULL,		NULL,		0,		0},
 };
-- 
1.7.1
