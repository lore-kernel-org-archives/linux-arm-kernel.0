From: jj@chaosbits.net (Jesper Juhl)
Date: Sun, 10 Apr 2011 19:06:16 +0200 (CEST)
Subject: [PATCH] ARM: Kconfig.debug: Remove unused CONFIG_DEBUG_ERRORS
In-Reply-To: <1302300518-7523-1-git-send-email-sboyd@codeaurora.org>
References: <1302300518-7523-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LNX.2.00.1104101904000.17706@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2011, Stephen Boyd wrote:

> This config option isn't actually used anywhere and can be safely
> removed. The last user was traps.c before commit 082f47a ([ARM]
> always allow dump_stack() to produce a backtrace, 2007-07-05).
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Ok, this patch looks sane, so feel free to add :
  Reviewed-by: Jesper Juhl <jj@chaosbits.net>

But, I see a lot of *_defconfig files in my copy of the tree that 
reference the option :

./arch/arm/configs/realview_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/ixp2000_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/netx_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/em_x270_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/tct_hammer_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/integrator_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/s3c6400_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/s5p6442_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/jornada720_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/imote2_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/mmp2_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/hackkit_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/lpd270_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/u8500_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/s5pc100_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/cerfcube_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/cm_x2xx_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/exynos4_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/simpad_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/colibri_pxa270_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/kirkwood_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/realview-smp_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/magician_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/mv78xx0_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/s5pv210_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/ns9xxx_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/corgi_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/ixp4xx_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/vexpress_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/pxa168_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/orion5x_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/pxa910_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/omap1_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/spitz_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/viper_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/pxa255-idp_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/colibri_pxa300_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/neponset_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/lubbock_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/collie_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/dove_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/rpc_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/mainstone_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/badge4_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/raumfeld_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/s5p64x0_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/ixp23xx_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/versatile_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/ezx_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/davinci_all_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/da8xx_omapl_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/zeus_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/s3c2410_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/am200epdkit_defconfig:CONFIG_DEBUG_ERRORS=y
./arch/arm/configs/ep93xx_defconfig:CONFIG_DEBUG_ERRORS=y

shouldn't those lines be removed as well?

I can submit a patch, but I thought you'd rather do it yourself..

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
