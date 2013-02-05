From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 14:58:53 +0800
Subject: [GIT PULL] arch_decomp_wdog() cleanup for 3.9
In-Reply-To: <20130115143203.GC6574@S2101-09.ap.freescale.net>
References: <20130115143203.GC6574@S2101-09.ap.freescale.net>
Message-ID: <20130205065850.GA16787@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

On Tue, Jan 15, 2013 at 10:32:04PM +0800, Shawn Guo wrote:
> The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:
> 
>   Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/cleanup-decompwdog-3.9
> 
> for you to fetch changes up to 1ff5f55a8c7b011f818434923a93afc48de0b2ee:
> 
>   ARM: samsung: remove unused arch_decomp_wdog() code (2013-01-11 13:55:35 +0800)
> 
> ----------------------------------------------------------------
> The series cleans up ARCH_HAS_DECOMP_WDOG and arch_decomp_wdog which
> are unused on ARM architecure.  Samsung has some code setting up wdog
> in arch_decomp_wdog().  But since CONFIG_S3C_BOOT_WATCHDOG is defined
> nowhere, it will not run.  Otherwise, system can not boot at all when
> wdog is set up but no one pats it.
> 
> ----------------------------------------------------------------
> Shawn Guo (3):
>       ARM: decompress: remove unused ARCH_HAS_DECOMP_WDOG
>       ARM: remove unused arch_decomp_wdog()
>       ARM: samsung: remove unused arch_decomp_wdog() code
> 
>  arch/arm/boot/compressed/decompress.c              |    2 --
>  arch/arm/mach-at91/include/mach/uncompress.h       |    2 --
>  arch/arm/mach-bcm2835/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-clps711x/include/mach/uncompress.h   |    2 --
>  arch/arm/mach-cns3xxx/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-davinci/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-dove/include/mach/uncompress.h       |    1 -
>  arch/arm/mach-ebsa110/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-ep93xx/include/mach/uncompress.h     |    2 --
>  arch/arm/mach-footbridge/include/mach/uncompress.h |    1 -
>  arch/arm/mach-gemini/include/mach/uncompress.h     |    2 --
>  arch/arm/mach-h720x/include/mach/uncompress.h      |    1 -
>  arch/arm/mach-integrator/include/mach/uncompress.h |    2 --
>  arch/arm/mach-iop13xx/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-iop32x/include/mach/uncompress.h     |    1 -
>  arch/arm/mach-iop33x/include/mach/uncompress.h     |    1 -
>  arch/arm/mach-ixp4xx/include/mach/uncompress.h     |    2 --
>  arch/arm/mach-kirkwood/include/mach/uncompress.h   |    1 -
>  arch/arm/mach-ks8695/include/mach/uncompress.h     |    1 -
>  arch/arm/mach-lpc32xx/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-mmp/include/mach/uncompress.h        |    6 -----
>  arch/arm/mach-msm/include/mach/uncompress.h        |    4 ---
>  arch/arm/mach-mv78xx0/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-mxs/include/mach/uncompress.h        |    1 -
>  arch/arm/mach-netx/include/mach/uncompress.h       |    1 -
>  arch/arm/mach-nomadik/include/mach/uncompress.h    |    2 --
>  arch/arm/mach-omap1/include/mach/uncompress.h      |    5 ----
>  arch/arm/mach-omap2/include/mach/uncompress.h      |    5 ----
>  arch/arm/mach-orion5x/include/mach/uncompress.h    |    1 -
>  arch/arm/mach-prima2/include/mach/uncompress.h     |    2 --
>  arch/arm/mach-pxa/include/mach/uncompress.h        |    5 ----
>  arch/arm/mach-realview/include/mach/uncompress.h   |    1 -
>  arch/arm/mach-rpc/include/mach/uncompress.h        |    5 ----
>  arch/arm/mach-s5p64x0/include/mach/uncompress.h    |   28 --------------------
>  arch/arm/mach-sa1100/include/mach/uncompress.h     |    1 -
>  arch/arm/mach-shark/include/mach/uncompress.h      |    1 -
>  arch/arm/mach-shmobile/include/mach/uncompress.h   |    2 --
>  arch/arm/mach-tegra/include/mach/uncompress.h      |    4 ---
>  arch/arm/mach-u300/include/mach/uncompress.h       |    1 -
>  arch/arm/mach-ux500/include/mach/uncompress.h      |    2 --
>  arch/arm/mach-versatile/include/mach/uncompress.h  |    1 -
>  arch/arm/mach-vt8500/include/mach/uncompress.h     |    1 -
>  arch/arm/mach-w90x900/include/mach/uncompress.h    |    2 --
>  arch/arm/plat-samsung/include/plat/uncompress.h    |   28 --------------------
>  arch/arm/plat-spear/include/plat/uncompress.h      |    1 -
>  45 files changed, 138 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
