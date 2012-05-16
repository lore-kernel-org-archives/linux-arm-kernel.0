From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 16 May 2012 12:25:21 +0200
Subject: [PATCH 2/2] ARM: EXYNOS: Remove superfluous udelay
In-Reply-To: <1337163921-31052-1-git-send-email-l.majewski@samsung.com>
References: <1337163921-31052-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1337163921-31052-2-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This udelay is not needed in the USB device PHY control code.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/setup-usb-phy.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
index 403923b..1af0a7f 100644
--- a/arch/arm/mach-exynos/setup-usb-phy.c
+++ b/arch/arm/mach-exynos/setup-usb-phy.c
@@ -73,7 +73,6 @@ static int exynos4210_usb_phy0_init(struct platform_device *pdev)
 
 	rstcon &= ~PHY0_SWRST_MASK;
 	writel(rstcon, EXYNOS4_RSTCON);
-	udelay(80);
 
 	return 0;
 }
-- 
1.7.2.3
