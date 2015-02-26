From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 26 Feb 2015 11:40:24 +0100
Subject: [PATCH] ARM: Enable CONFIG_GENERIC_IRQ_SHOW_LEVEL
Message-ID: <1424947224-7797-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Several interrupt controllers support both edge and level interrupts, so
it's useful to provide that information in /proc/interrupts.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 55f1d9ba4b204a36..d86b56521feabcda 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -21,6 +21,7 @@ config ARM
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-- 
1.9.1
