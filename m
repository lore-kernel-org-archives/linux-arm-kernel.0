From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  8 Jul 2014 18:21:13 +0200
Subject: [PATCHv2 3/6] ARM: at91: select ATMEL_SDRAMC when using OF
In-Reply-To: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404836476-23787-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using device tree, select the Atmel RAM controller driver to handle its
clocks.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 45b55e0f0db6..7a69ffd93b6b 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -49,6 +49,8 @@ config SOC_AT91SAM9
 	select GENERIC_CLOCKEVENTS
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
+	select MEMORY if USE_OF
+	select ATMEL_SDRAMC if USE_OF
 
 config SOC_SAMA5
 	bool
@@ -58,6 +60,8 @@ config SOC_SAMA5
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
+	select MEMORY
+	select ATMEL_SDRAMC
 
 menu "Atmel AT91 System-on-Chip"
 
-- 
1.9.1
