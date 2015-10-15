From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:33:50 +0900
Subject: [PATCH 2/6] ARM: shmobile: r8a7778: Make r8a7778_init_irq_dt() static
In-Reply-To: <cover.1444868660.git.horms+renesas@verge.net.au>
References: <cover.1444868660.git.horms+renesas@verge.net.au>
Message-ID: <20e73335dc35bf5e200173e6ed99f6a2b32f8857.1444868660.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
setup code"), r8a7778_init_irq_dt() is no longer used outside
setup-r8a7778.c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index b0c9986d022d..0ab9d3272875 100644
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
2.1.4
