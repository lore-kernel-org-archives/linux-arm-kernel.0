From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 22 Aug 2011 15:17:04 -0300
Subject: [PATCH v2 2/2] ARM: mx27: Print silicon revision on boot
In-Reply-To: <1314037024-9015-1-git-send-email-fabio.estevam@freescale.com>
References: <1314037024-9015-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1314037024-9015-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Silicon revision is useful information to have during kernel boot.

Print the MX27 silicon revision.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:

- Use generic imx function to print silicon revision.

 arch/arm/mach-imx/clock-imx27.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 583f251..a1ca276 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -754,6 +754,7 @@ int __init mx27_clocks_init(unsigned long fref)
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_ICEDCC)
 	clk_enable(&uart1_clk);
 #endif
+	imx_print_silicon_rev("MX27", mx27_revision());
 
 	mxc_timer_init(&gpt1_clk, MX27_IO_ADDRESS(MX27_GPT1_BASE_ADDR),
 			MX27_INT_GPT1);
-- 
1.7.1
