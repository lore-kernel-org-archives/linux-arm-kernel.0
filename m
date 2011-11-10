From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Nov 2011 10:11:56 +0100
Subject: [PATCH 2/3] ARM i.MX: Merge i.MX5 support into mach-imx
In-Reply-To: <1320915966-8063-3-git-send-email-s.hauer@pengutronix.de>
References: <1320915966-8063-1-git-send-email-s.hauer@pengutronix.de>
 <1320915966-8063-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20111110091156.GX16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 10:06:05AM +0100, Sascha Hauer wrote:
> This patch moves the contents of arch/arm/mach-mx5 to arch/arm/mach-imx
> and adjusts the Makefile/Kconfig entries in a way that it's possible
> to compile i.MX5 together with i.MX3/6.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/Makefile                                  |    1 -
>  arch/arm/mach-imx/Kconfig                          |  239 +++++++++++++++++++
>  arch/arm/mach-imx/Makefile                         |   21 ++
>  arch/arm/{mach-mx5 => mach-imx}/clock-mx51-mx53.c  |    2 +-
>  arch/arm/{mach-mx5/cpu.c => mach-imx/cpu-imx5.c}   |    0
>  arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.c      |    0
>  arch/arm/{mach-mx5 => mach-imx}/cpu_op-mx51.h      |    0
>  .../crm_regs.h => mach-imx/crm-regs-imx5.h}        |    0
>  arch/arm/{mach-mx5 => mach-imx}/devices-imx50.h    |    0
>  arch/arm/{mach-mx5 => mach-imx}/devices-imx51.h    |    0
>  arch/arm/{mach-mx5 => mach-imx}/devices-imx53.h    |    0
>  arch/arm/{mach-mx5 => mach-imx}/efika.h            |    0
>  arch/arm/{mach-mx5/ehci.c => mach-imx/ehci-imx5.c} |    0
>  .../eukrea_mbimx51-baseboard.c                     |    0
>  .../eukrea_mbimxsd-baseboard.c                     |    0
>  arch/arm/{mach-mx5 => mach-imx}/imx51-dt.c         |    0
>  arch/arm/{mach-mx5 => mach-imx}/imx53-dt.c         |    0
>  .../board-cpuimx51.c => mach-imx/mach-cpuimx51.c}  |    0
>  .../mach-cpuimx51sd.c}                             |    0
>  .../board-mx50_rdp.c => mach-imx/mach-mx50_rdp.c}  |    0
>  .../board-mx51_3ds.c => mach-imx/mach-mx51_3ds.c}  |    0
>  .../mach-mx51_babbage.c}                           |    0
>  .../mach-mx51_efikamx.c}                           |    0
>  .../mach-mx51_efikasb.c}                           |    0
>  .../board-mx53_ard.c => mach-imx/mach-mx53_ard.c}  |    0
>  .../board-mx53_evk.c => mach-imx/mach-mx53_evk.c}  |    0
>  .../mach-mx53_loco.c}                              |    0
>  .../board-mx53_smd.c => mach-imx/mach-mx53_smd.c}  |    0
>  arch/arm/{mach-mx5/mm.c => mach-imx/mm-imx5.c}     |    0
>  arch/arm/{mach-mx5 => mach-imx}/mx51_efika.c       |    0
>  arch/arm/{mach-mx5/system.c => mach-imx/pm-imx5.c} |   89 +++++++-
>  arch/arm/mach-mx5/Kconfig                          |  244 --------------------
>  arch/arm/mach-mx5/Makefile                         |   26 --
>  arch/arm/mach-mx5/pm-imx5.c                        |   83 -------
>  arch/arm/plat-mxc/Kconfig                          |   15 +-

Forgot to handle Makefile.boot. Will update.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
