From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:13 +0900
Subject: [PATCH 12/17] ARM: S5PV310: Add PDMA clocks
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562013-19972-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Define PDMA clocks for the controller 0 & 1.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 58c9d33..ace8f52 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -467,6 +467,16 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv310_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 10),
 	}, {
+		.name		= "pdma",
+		.id		= 0,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "pdma",
+		.id		= 1,
+		.enable		= s5pv310_clk_ip_fsys_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
 		.name		= "adc",
 		.id		= -1,
 		.enable		= s5pv310_clk_ip_peril_ctrl,
-- 
1.6.2.5
