From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:44 +0900
Subject: [PATCH 03/12] ARM: shmobile: r8a7740: Add interim sh-eth device name
 to clocks list
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

When we use the ethernet device via DT setup, we need to add it
to a lookup list until this is properly handled later in a DT-only
fashion.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index c0d39aa..5bd8da0 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -592,6 +592,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
+	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),
-- 
1.7.10.4
