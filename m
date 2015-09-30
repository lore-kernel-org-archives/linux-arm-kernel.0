From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 30 Sep 2015 17:50:19 +0200
Subject: [PATCH 2/3] ARM: shmobile: r8a7778: Make r8a7778_init_irq_dt() static
In-Reply-To: <1443628220-1352-1-git-send-email-geert+renesas@glider.be>
References: <1443628220-1352-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1443628220-1352-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
setup code"), r8a7778_init_irq_dt() is no longer used outside
setup-r8a7778.c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index b0c9986d022d8664..0ab9d32728758a9a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -42,7 +42,8 @@ static void __init r8a7778_timer_init(void)
 
 #define INT2NTSR0	0x00018 /* 0xfe700018 */
 #define INT2NTSR1	0x0002c /* 0xfe70002c */
-void __init r8a7778_init_irq_dt(void)
+
+static void __init r8a7778_init_irq_dt(void)
 {
 	void __iomem *base = ioremap_nocache(0xfe700000, 0x00100000);
 
-- 
1.9.1
