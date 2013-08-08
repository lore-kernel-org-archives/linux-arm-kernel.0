From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 12:29:54 +0200
Subject: [PATCH 5/6] ARM: at91: move sama5d3 SoC to common clk
In-Reply-To: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
References: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375957794-11559-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the selection of AT91_USE_OLD_CLK when selecting sama5d3
SoC support. This will enable automatically enable COMMON_CLK_AT91 option
and add support for at91 common clk implementation.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/mach-at91/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 97033f7..b4f7d6f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -86,7 +86,6 @@ config SOC_SAMA5D3
 	select SOC_SAMA5
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU1
-	select AT91_USE_OLD_CLK
 	select HAVE_AT91_UTMI
 	select HAVE_AT91_SMD
 	select HAVE_AT91_USB_CLK
-- 
1.7.9.5
