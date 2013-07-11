From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Thu, 11 Jul 2013 18:52:32 +0900
Subject: [PATCH 3/4] ARM: shmobile: smp-r8a7790: rename s/cabar/bar/g as well
In-Reply-To: <51DE7FF4.5050800@renesas.com>
References: <20130710104151.20742.56398.sendpatchset@w520>
 <51DE7FF4.5050800@renesas.com>
Message-ID: <51DE8060.5010400@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I don't have strong opinion on this one, either  Leave it to you.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 arch/arm/mach-shmobile/smp-r8a7790.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index e8c2636..1448e387 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -35,17 +35,17 @@
 enum { R8A7790_CLST_CA15, R8A7790_CLST_CA7, R8A7790_CLST_NR };
 
 static struct {
-	unsigned int cabar;
+	unsigned int bar;
 	unsigned int rescnt;
 	unsigned int rescnt_magic;
 } r8a7790_clst[R8A7790_CLST_NR] = {
 	[R8A7790_CLST_CA15] = {
-		.cabar = CA15BAR,
+		.bar = CA15BAR,
 		.rescnt = CA15RESCNT,
 		.rescnt_magic = 0xa5a50000,
 	},
 	[R8A7790_CLST_CA7] = {
-		.cabar = CA7BAR,
+		.bar = CA7BAR,
 		.rescnt = CA7RESCNT,
 		.rescnt_magic = 0x5a5a0000,
 	},
@@ -63,8 +63,8 @@ static void r8a7790_deassert_reset(unsigned int cpu)
 	/* setup reset vectors */
 	p = ioremap_nocache(RST, 0x63);
 	bar = (MERAM >> 8) & 0xfffffc00;
-	writel_relaxed(bar, p + r8a7790_clst[clst_id].cabar);
-	writel_relaxed(bar | 0x10, p + r8a7790_clst[clst_id].cabar);
+	writel_relaxed(bar, p + r8a7790_clst[clst_id].bar);
+	writel_relaxed(bar | 0x10, p + r8a7790_clst[clst_id].bar);
 
 	/* enable per-core clocks */
 	mask = BIT(3 - r8a7790_cpu_id(cpu));
-- 
1.8.3.2
