From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 21 Oct 2010 09:58:30 +0900
Subject: [PATCH 2/5] ARM: S5PV210: Add DMA operation clock
In-Reply-To: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
References: <1287622713-1657-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1287622713-1657-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Seungwhan Youn <sw.youn@samsung.com>

This patch adds DMA operation clock which is disabled as default.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
Acked-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 38ad7e5..019c3a6 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -311,6 +311,18 @@ static struct clk_ops clk_fout_apll_ops = {
 
 static struct clk init_clocks_disable[] = {
 	{
+		.name		= "pdma",
+		.id		= 0,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "pdma",
+		.id		= 1,
+		.parent		= &clk_hclk_psys.clk,
+		.enable		= s5pv210_clk_ip0_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
 		.name		= "rot",
 		.id		= -1,
 		.parent		= &clk_hclk_dsys.clk,
-- 
1.6.2.5
