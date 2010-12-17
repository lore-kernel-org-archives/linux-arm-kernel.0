From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 14:00:13 +0900
Subject: [PATCH 13/17] ARM: S5PV310: Add AC97 clocks
In-Reply-To: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <1292562013-20004-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Define clock for the AC97 controller

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv310/clock.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index ace8f52..189198a 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -517,6 +517,11 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv310_clk_ip_peril_ctrl,
 		.ctrlbit	= (1 << 18),
 	}, {
+		.name		= "ac97",
+		.id		= -1,
+		.enable		= s5pv310_clk_ip_peril_ctrl,
+		.ctrlbit	= (1 << 27),
+	}, {
 		.name		= "fimg2d",
 		.id		= -1,
 		.enable		= s5pv310_clk_ip_image_ctrl,
-- 
1.6.2.5
