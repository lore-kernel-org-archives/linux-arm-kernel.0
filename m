From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 11 Nov 2011 20:19:54 +0800
Subject: [PATCH] ARM: pxa168/gplugd: add the correct SSP device
Message-ID: <1321013994-6443-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no SSP0, but SSP2 is used on gplugd.

Cc: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-mmp/gplugd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 6915656..0469c74 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -182,7 +182,7 @@ static void __init gplugd_init(void)
 
 	/* on-chip devices */
 	pxa168_add_uart(3);
-	pxa168_add_ssp(0);
+	pxa168_add_ssp(2);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
-- 
1.7.5.4
