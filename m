From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 3 Apr 2013 17:40:49 +0300
Subject: [PATCH v9 14/14] clk: tegra: Remove forced clk_enable of uartd
In-Reply-To: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1365000110-8916-16-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART driver enables the console uart clock, so we don't need to do that
anymore in this file.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index e2a7fa1..0db81dd 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -2011,7 +2011,7 @@ static __initdata struct tegra_clk_init_table init_table[] = {
 	{uarta, pll_p, 408000000, 0},
 	{uartb, pll_p, 408000000, 0},
 	{uartc, pll_p, 408000000, 0},
-	{uartd, pll_p, 408000000, 1},
+	{uartd, pll_p, 408000000, 0},
 	{pll_a, clk_max, 564480000, 1},
 	{pll_a_out0, clk_max, 11289600, 1},
 	{extern1, pll_a_out0, 0, 1},
-- 
1.7.7.rc0.72.g4b5ea.dirty
