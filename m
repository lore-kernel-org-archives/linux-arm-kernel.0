From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:30 -0300
Subject: [PATCH 3/17] ARM: mach-imx: iomux-imx31: Staticize mxc_pin_alloc_map
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warning:

arch/arm/mach-imx/iomux-imx31.c:43:15: warning: symbol 'mxc_pin_alloc_map' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/iomux-imx31.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
index cabefbc..7c66805 100644
--- a/arch/arm/mach-imx/iomux-imx31.c
+++ b/arch/arm/mach-imx/iomux-imx31.c
@@ -40,7 +40,7 @@ static DEFINE_SPINLOCK(gpio_mux_lock);
 
 #define IOMUX_REG_MASK (IOMUX_PADNUM_MASK & ~0x3)
 
-unsigned long mxc_pin_alloc_map[NB_PORTS * 32 / BITS_PER_LONG];
+static unsigned long mxc_pin_alloc_map[NB_PORTS * 32 / BITS_PER_LONG];
 /*
  * set the mode for a IOMUX pin.
  */
-- 
1.7.9.5
