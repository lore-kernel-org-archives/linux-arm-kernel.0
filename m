From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Wed, 15 Jun 2016 12:55:52 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
In-Reply-To: <1465987689-14812-2-git-send-email-tony@atomide.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <1465987689-14812-2-git-send-email-tony@atomide.com>
Message-ID: <20160615105552.GN29844@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 June 2016 03:48:08 Tony Lindgren wrote:
> Let's drop the last two remaining omap3 legacy boot board files.
> Let's only use the device tree based booting known to work for
> these two boards.
> 
> We still have two omap3 boards booting in legacy mode in addition
> to device tree based booting. All the other ten or so omap2+ SoCs
> have been booting using device tree mode only for years now. This
> has allowed us to get rid of quite a bit of arch/arm/mach-omap2
> related platform init code in favor of dts and driver changes.
> 
> Pretty much the only remaining known users for omap3 legacy boot
> board files are Kevin's and Russell's boot test systems, and N900
> kernel tree maintained by Pali and Ivaylo. And all of them are
> also supporting the device tree based booting. The legacy booting
> mode has been kept around mostly to verify against regressions.
> 
> As there is still a slim chance of possible other uses of the
> mainline kernel for these boards, let's just drop the board
> files for v4.8, and let's not touch the related platform init
> code until around v4.9 time if no issues are found. This makes
> it trivial for us to add back the board files with a simple revert.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Kconfig                  |    6 -
>  arch/arm/mach-omap2/Makefile                 |    3 -
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 1317 --------------------------
>  arch/arm/mach-omap2/board-rx51-video.c       |   67 --
>  arch/arm/mach-omap2/board-rx51.c             |  141 ---
>  arch/arm/mach-omap2/board-rx51.h             |   11 -
>  6 files changed, 1545 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51-video.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51.c
>  delete mode 100644 arch/arm/mach-omap2/board-rx51.h

Hi! I just quickly looked at N900 status matrix https://elinux.org/N900
and there is still one thing not finished in DT: It is slot-name for
omap_hsmmc driver. So switch from legacy board code to DT is regression.

-- 
Pali Roh?r
pali.rohar at gmail.com
