From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 24 Oct 2011 05:49:59 -0400
Subject: [PATCH 10/12] ARM: mach-shark: properly disable CPU idle call
In-Reply-To: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
Message-ID: <1319449801-12367-11-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-shark/core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shark/core.c b/arch/arm/mach-shark/core.c
index feda3ca7fc..ee235625d7 100644
--- a/arch/arm/mach-shark/core.c
+++ b/arch/arm/mach-shark/core.c
@@ -150,11 +150,17 @@ static struct sys_timer shark_timer = {
 	.init		= shark_timer_init,
 };
 
+static void shark_init_irq(void)
+{
+	disable_hlt();
+}
+
 MACHINE_START(SHARK, "Shark")
 	/* Maintainer: Alexander Schulz */
 	.atag_offset	= 0x3000,
 	.map_io		= shark_map_io,
 	.init_irq	= shark_init_irq,
+	.init_machine	= shark_init_machine,
 	.timer		= &shark_timer,
 	.dma_zone_size	= SZ_4M,
 MACHINE_END
-- 
1.7.7.1.431.g10b2a
