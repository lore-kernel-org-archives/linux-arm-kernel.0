From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 22:22:41 +0200
Subject: [GIT PULL] Samsung cleanup for v3.2
In-Reply-To: <001901cc76b8$018d4fc0$04a7ef40$%kim@samsung.com>
References: <001901cc76b8$018d4fc0$04a7ef40$%kim@samsung.com>
Message-ID: <201109202222.41747.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 September 2011, Kukjin Kim wrote:
> This is Samsung cleanup for v3.2.
> 
> Please pull from:
>   git://github.com/kgene/linux-samsung.git next-samsung-cleanup

Pulled into arm-soc/next/cleanup.

> If any problems, please let me know.

One tiny conflict with Nico's cross-platform series:

+ 
+ MACHINE_START(SMDKC210, "SMDKC210")
+       /* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
 -      .boot_params    = S5P_PA_SDRAM + 0x100,
++      .atag_offset    = 0x100,
+       .init_irq       = exynos4_init_irq,
+       .map_io         = smdkv310_map_io,
+       .init_machine   = smdkv310_machine_init,
+       .timer          = &exynos4_timer,
+ MACHINE_END

I'll handle this in the upstream submission.

Thanks,

	Arnd
