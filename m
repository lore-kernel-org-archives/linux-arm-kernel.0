From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Sep 2012 00:37:17 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
Message-ID: <1348007837-23187-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't load the FEC MAC address from OCOTP, but use the one supplied
via device tree by U-Boot. This is the preferred way, every DT-capable
bootloader does set up "mac-address" and "local-mac-address" properties
into the DT passed to the kernel.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 170a930..71d47f5 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -255,8 +255,6 @@ static void __init imx28_evk_post_init(void)
 
 static void __init m28evk_init(void)
 {
-	update_fec_mac_prop(OUI_DENX);
-
 	mxsfb_pdata.mode_list = m28evk_video_modes;
 	mxsfb_pdata.mode_count = ARRAY_SIZE(m28evk_video_modes);
 	mxsfb_pdata.default_bpp = 16;
-- 
1.7.10.4
