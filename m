From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  7 Jun 2013 17:36:43 +0200
Subject: [RFC PATCH 21/50] ARM: at91: move at91sam9 SoCs to new at91 clk implem
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1370619403-18976-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of common clk framework for all at91sam9 SoCs

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7256b81..add1719 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -32,6 +32,7 @@ config HAVE_AT91_SMD
 
 config SOC_AT91SAM9
 	bool
+	select COMMON_CLK
 	select AT91_SAM9_TIME
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
-- 
1.7.9.5
