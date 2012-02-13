From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 13 Feb 2012 17:30:25 +0100
Subject: [PATCH 4/4] ARM: OMAP1: kconfig: Enable IRQ_DOMAIN by default for
 OMAP1 platforms
In-Reply-To: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
References: <1329150625-8604-2-git-send-email-b-cousson@ti.com>
Message-ID: <1329150625-8604-5-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devices that can act as an interrupt controller like the
GPIO are going to be handled using the IRQ domain mechanism
in order to avoid the static IRQ mapping done so far inside
plat-omap/irqs.h.

Enable IRQ_DOMAIN by default to allow the drivers shared with
OMAP2+ to compile properly on OMAP1 platforms.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 734009a..e289dd2 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -14,6 +14,7 @@ config ARCH_OMAP1
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
 	select HAVE_IDE
 	select NEED_MACH_MEMORY_H
 	help
-- 
1.7.0.4
