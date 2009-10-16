From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 16 Oct 2009 12:09:06 -0700
Subject: [PATCH 02/46] DaVinci: DM365: Correct USB parent clock
In-Reply-To: <1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
References: <1255720190-7452-1-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-2-git-send-email-khilman@deeprootsystems.com>
	<1255720190-7452-3-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255720190-7452-4-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sandeep Paulraj <s-paulraj@ti.com>

The parent clock for the USB source clock is actually PLL1 aux clock,
not PLL2 sysclk1.

Signed-off-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/dm365.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e815174..6c948b1 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -369,7 +369,7 @@ static struct clk timer3_clk = {
 
 static struct clk usb_clk = {
 	.name		= "usb",
-	.parent		= &pll2_sysclk1,
+	.parent		= &pll1_aux_clk,
 	.lpsc		= DAVINCI_LPSC_USB,
 };
 
-- 
1.6.4.3
