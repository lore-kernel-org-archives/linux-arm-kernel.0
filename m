From: ccross@android.com (Colin Cross)
Date: Mon, 21 Feb 2011 18:39:51 -0800
Subject: [PATCH 6/7] ARM: tegra: common: Enable core clocks
In-Reply-To: <1298342392-21236-1-git-send-email-ccross@android.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
Message-ID: <1298342392-21236-7-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the cpu, emc (memory controller) and csite (debug and
trace controller) clocks during init to prevent them from
being disabled by the bootloader clock disabling code.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/common.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 14fa533..516e100 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -56,6 +56,9 @@ static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
 	{ "sclk",	"pll_p_out4",	108000000,	true },
 	{ "hclk",	"sclk",		108000000,	true },
 	{ "pclk",	"hclk",		54000000,	true },
+	{ "csite",	NULL,		0,		true },
+	{ "emc",	NULL,		0,		true },
+	{ "cpu",	NULL,		0,		true },
 	{ NULL,		NULL,		0,		0},
 };
 
-- 
1.7.3.1
