From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 25 Nov 2013 15:20:23 +0200
Subject: [PATCH 2/2] clk: tegra: fix pllcx pdiv for Tegra124
In-Reply-To: <1385385623-8952-1-git-send-email-pdeschrijver@nvidia.com>
References: <1385385623-8952-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1385385623-8952-3-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The post divider field for pllcx on Tegra124 has some more allowed values than
the one on Tegra114. Fix the code to reflect this.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra124.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
index 54af043..863c38b 100644
--- a/drivers/clk/tegra/clk-tegra124.c
+++ b/drivers/clk/tegra/clk-tegra124.c
@@ -263,8 +263,11 @@ static struct div_nmp pllcx_nmp = {
 static struct pdiv_map pllc_p[] = {
 	{ .pdiv = 1, .hw_val = 0 },
 	{ .pdiv = 2, .hw_val = 1 },
+	{ .pdiv = 3, .hw_val = 2 },
 	{ .pdiv = 4, .hw_val = 3 },
+	{ .pdiv = 6, .hw_val = 4 },
 	{ .pdiv = 8, .hw_val = 5 },
+	{ .pdiv = 12, .hw_val = 6 },
 	{ .pdiv = 16, .hw_val = 7 },
 	{ .pdiv = 0, .hw_val = 0 },
 };
-- 
1.7.7.rc0.72.g4b5ea.dirty
