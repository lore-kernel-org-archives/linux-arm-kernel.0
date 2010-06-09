From: baruch@tkos.co.il (Baruch Siach)
Date: Wed,  9 Jun 2010 14:07:01 +0300
Subject: [PATCH 2/3] mx25pdk: register watchdog device
In-Reply-To: <cover.1276081393.git.baruch@tkos.co.il>
References: <cover.1276081393.git.baruch@tkos.co.il>
Message-ID: <a8fd2ca108974bd7fac663c470b3b22e0543d41c.1276081393.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/mach-mx25/mach-mx25pdk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/mach-mx25pdk.c b/arch/arm/mach-mx25/mach-mx25pdk.c
index 83d7410..9ef99f8 100644
--- a/arch/arm/mach-mx25/mach-mx25pdk.c
+++ b/arch/arm/mach-mx25/mach-mx25pdk.c
@@ -147,6 +147,7 @@ static void __init mx25pdk_init(void)
 	mxc_register_device(&mxc_nand_device, &mx25pdk_nand_board_info);
 	mxc_register_device(&mx25_rtc_device, NULL);
 	mxc_register_device(&mx25_fb_device, &mx25pdk_fb_pdata);
+	mxc_register_device(&mxc_wdt, NULL);
 
 	mx25pdk_fec_reset();
 	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
-- 
1.7.1
