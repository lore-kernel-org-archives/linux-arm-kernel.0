From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Mar 2013 22:05:31 +0800
Subject: [PATCH v2 5/5] ARM: imx: Remove cpufreq driver
In-Reply-To: <1364389294-1997-6-git-send-email-mpa@pengutronix.de>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
 <1364389294-1997-6-git-send-email-mpa@pengutronix.de>
Message-ID: <20130327140529.GG2674@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 02:01:34PM +0100, Markus Pargmann wrote:
> The old cpufreq driver is not necessary anymore with DT and
> cpufreq-cpu0.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/Kconfig                      |   7 --
>  arch/arm/mach-imx/Makefile            |   1 -
>  arch/arm/mach-imx/cpu_op-mx51.c       |  31 -----
>  arch/arm/mach-imx/cpu_op-mx51.h       |  14 ---
>  arch/arm/mach-imx/cpufreq.c           | 206 ----------------------------------
>  arch/arm/mach-imx/mach-cpuimx51sd.c   |   5 -
>  arch/arm/mach-imx/mach-mx51_babbage.c |   4 -
>  7 files changed, 268 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/cpu_op-mx51.c

Target cpu_op-mx51.o should be removed from Makefile then.

I fixed it up and applied the series expect the first patch.  I expect
you will send follow-up patches to add imx51 operating-points into
device tree though.

Shawn
