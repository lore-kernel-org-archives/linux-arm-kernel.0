From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 18 Nov 2010 08:28:19 +0200
Subject: [PATCH 38/51] ARM: imx: move mx25 support to mach-imx
In-Reply-To: <1290029419-21435-38-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
	<1290029419-21435-38-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20101118062819.GA10415@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Tanks for all this work.

Once this get merged we can get rid of the ugly '#ifdef CONFIG_MACH_MX27' in 
drivers/media/video/mx2_camera.c. Should such a patch go via Sascha's tree or 
the V4L tree?

baruch

On Wed, Nov 17, 2010 at 10:30:06PM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/Makefile                              |    2 +-
>  arch/arm/mach-imx/Kconfig                      |   85 +++++--
>  arch/arm/mach-imx/Makefile                     |    6 +
>  arch/arm/mach-imx/Makefile.boot                |    4 +
>  arch/arm/mach-imx/clock-imx25.c                |  332 ++++++++++++++++++++++++
>  arch/arm/mach-imx/devices-imx25.h              |   86 ++++++
>  arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |  296 +++++++++++++++++++++
>  arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |  161 ++++++++++++
>  arch/arm/mach-imx/mach-mx25_3ds.c              |  223 ++++++++++++++++
>  arch/arm/mach-imx/mm-imx25.c                   |   62 +++++
>  arch/arm/mach-mx25/Kconfig                     |   43 ---
>  arch/arm/mach-mx25/Makefile                    |    5 -
>  arch/arm/mach-mx25/Makefile.boot               |    3 -
>  arch/arm/mach-mx25/clock.c                     |  332 ------------------------
>  arch/arm/mach-mx25/devices-imx25.h             |   86 ------
>  arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c  |  296 ---------------------
>  arch/arm/mach-mx25/mach-cpuimx25.c             |  161 ------------
>  arch/arm/mach-mx25/mach-mx25_3ds.c             |  223 ----------------
>  arch/arm/mach-mx25/mm.c                        |   62 -----
>  arch/arm/plat-mxc/Kconfig                      |    5 -
>  20 files changed, 1240 insertions(+), 1233 deletions(-)
>  create mode 100644 arch/arm/mach-imx/clock-imx25.c
>  create mode 100644 arch/arm/mach-imx/devices-imx25.h
>  create mode 100644 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
>  create mode 100644 arch/arm/mach-imx/mach-eukrea_cpuimx25.c
>  create mode 100644 arch/arm/mach-imx/mach-mx25_3ds.c
>  create mode 100644 arch/arm/mach-imx/mm-imx25.c
>  delete mode 100644 arch/arm/mach-mx25/Kconfig
>  delete mode 100644 arch/arm/mach-mx25/Makefile
>  delete mode 100644 arch/arm/mach-mx25/Makefile.boot
>  delete mode 100644 arch/arm/mach-mx25/clock.c
>  delete mode 100644 arch/arm/mach-mx25/devices-imx25.h
>  delete mode 100644 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
>  delete mode 100644 arch/arm/mach-mx25/mach-cpuimx25.c
>  delete mode 100644 arch/arm/mach-mx25/mach-mx25_3ds.c
>  delete mode 100644 arch/arm/mach-mx25/mm.c

[snip]

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
