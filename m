From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 23 Jan 2015 18:09:30 +0100
Subject: [PATCH v3 4/5] ARM: at91/dt: select DUMB_IRQ_DEMUX for all at91 SoCs
In-Reply-To: <1422032971-14139-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1422032971-14139-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1422032971-14139-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Older at91 SoCs need a virtual dumb irq demuxer to gracefully support the
fact that irq1 is shared by several devices and a timer.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 2395c68..8ff2c2a 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -28,6 +28,7 @@ config HAVE_AT91_H32MX
 config SOC_AT91SAM9
 	bool
 	select ATMEL_AIC_IRQ
+	select DUMB_DEMUX_IRQ
 	select COMMON_CLK_AT91
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
@@ -98,6 +99,7 @@ if SOC_SAM_V4_V5
 config SOC_AT91RM9200
 	bool "AT91RM9200"
 	select ATMEL_AIC_IRQ
+	select DUMB_DEMUX_IRQ
 	select COMMON_CLK_AT91
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
-- 
1.9.1
