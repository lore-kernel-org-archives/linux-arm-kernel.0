From: joe@perches.com (Joe Perches)
Date: Tue, 19 May 2015 18:37:49 -0700
Subject: [PATCH 01/12] ARM: mach-imx: iomux-imx31: Use DECLARE_BITMAP
In-Reply-To: <cover.1432085659.git.joe@perches.com>
References: <cover.1432085659.git.joe@perches.com>
Message-ID: <04e6c29d921d20f6089dd5d13f2c35bbe362eb0e.1432085659.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the generic mechanism to declare a bitmap instead of unsigned long.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-imx/iomux-imx31.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/iomux-imx31.c b/arch/arm/mach-imx/iomux-imx31.c
index d6a3075..6dd22ca 100644
--- a/arch/arm/mach-imx/iomux-imx31.c
+++ b/arch/arm/mach-imx/iomux-imx31.c
@@ -40,7 +40,7 @@ static DEFINE_SPINLOCK(gpio_mux_lock);
 
 #define IOMUX_REG_MASK (IOMUX_PADNUM_MASK & ~0x3)
 
-static unsigned long mxc_pin_alloc_map[NB_PORTS * 32 / BITS_PER_LONG];
+static DECLARE_BITMAP(mxc_pin_alloc_map, NB_PORTS * 32);
 /*
  * set the mode for a IOMUX pin.
  */
-- 
2.1.2
