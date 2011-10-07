From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 07 Oct 2011 17:00:24 +0530
Subject: [PATCH V2 0/2] Add a common macro for creating struct clk_lookup
	entries
In-Reply-To: <1317981211-15745-1-git-send-email-rajeshwari.s@samsung.com>
References: <1317981211-15745-1-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <4E8EE2D0.6070103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 October 2011 03:23 PM, Rajeshwari Shinde wrote:
> This patchset consolidates the macro that creates 'struct clk_lookup'
> entries by introducing a common macro 'CLKDEV_INIT' as suggested by
> Russell King. Few of the platforms have been modified to use this new macro.
>
> I have done the replacement by using python script. I have only build tested
> for below platforms with existing defconfigs.
>
> Changes since V1:
> - Removed "&" and "," from the CLKDEV_INIT macro.
> - Replaced the platform specific macros to use the new CLKDEV_INIT macro.
> - Rebased the patches on the latest master branch of Linux-Next.
>
> Rajeshwari Shinde (2):
>    ARM: CLKDEV: Add Common Macro for clk_lookup
>    ARM: Using CLKDEV_INIT for creating clk_lookup instance
>
>   arch/arm/mach-davinci/board-dm646x-evm.c |    5 +-
>   arch/arm/mach-davinci/clock.h            |    7 --
>   arch/arm/mach-davinci/da830.c            |  101 ++++++++++----------
>   arch/arm/mach-davinci/da850.c            |   95 ++++++++++----------
>   arch/arm/mach-davinci/dm355.c            |   87 +++++++++---------
>   arch/arm/mach-davinci/dm365.c            |  113 +++++++++++-----------
>   arch/arm/mach-davinci/dm644x.c           |   77 ++++++++--------
>   arch/arm/mach-davinci/dm646x.c           |   81 ++++++++--------
>   arch/arm/mach-davinci/tnetv107x.c        |  133 +++++++++++++-------------
>   arch/arm/mach-ep93xx/clock.c             |   61 ++++++-------
>   arch/arm/mach-imx/clock-imx1.c           |   38 +++-----
>   arch/arm/mach-imx/clock-imx21.c          |   91 +++++++++----------
>   arch/arm/mach-imx/clock-imx25.c          |   79 +++++++---------
>   arch/arm/mach-imx/clock-imx27.c          |  111 ++++++++++------------
>   arch/arm/mach-imx/clock-imx31.c          |  103 ++++++++++-----------
>   arch/arm/mach-imx/clock-imx35.c          |  117 +++++++++++------------
>   arch/arm/mach-lpc32xx/clock.c            |   75 +++++++--------
>   arch/arm/mach-mx5/clock-mx51-mx53.c      |  149 ++++++++++++++----------------
>   arch/arm/mach-mxs/clock-mx23.c           |   39 +++-----
>   arch/arm/mach-mxs/clock-mx28.c           |   71 +++++++--------
>   arch/arm/mach-tcc8k/clock.c              |  107 ++++++++++-----------
>   include/linux/clkdev.h                   |    7 ++
>   22 files changed, 838 insertions(+), 909 deletions(-)
>

Consider applying the macro to following files too.

CLKDEV_CON_DEV_ID
arch/arm/mach-at91/at91cap9.c
arch/arm/mach-at91/at91rm9200.c
arch/arm/mach-at91/at91sam9260.c
arch/arm/mach-at91/at91sam9261.c
arch/arm/mach-at91/at91sam9263.c
arch/arm/mach-at91/at91sam9g45.c
arch/arm/mach-at91/at91sam9rl.c
arch/arm/mach-at91/clock.h

CLKDEV_CON_ID
arch/arm/mach-at91/at91sam9g45.c
arch/arm/mach-at91/clock.h
arch/arm/mach-shmobile/clock-sh7367.c
arch/arm/mach-shmobile/clock-sh7372.c
arch/arm/mach-shmobile/clock-sh7377.c
arch/arm/mach-shmobile/clock-sh73a0.c

INIT_CLKREG
arch/arm/mach-mmp/clock.h
arch/arm/mach-mmp/mmp2.c
arch/arm/mach-mmp/pxa168.c
arch/arm/mach-mmp/pxa910.c
arch/arm/mach-pxa/clock.h
arch/arm/mach-pxa/eseries.c
arch/arm/mach-pxa/pxa25x.c
arch/arm/mach-pxa/pxa27x.c
arch/arm/mach-pxa/pxa300.c
arch/arm/mach-pxa/pxa320.c
arch/arm/mach-pxa/pxa3xx.c
arch/arm/mach-pxa/pxa95x.c

DEF_LOOKUP
DEF_LOOKUP_CON
arch/arm/mach-u300/clock.c

DEF_CLKLOOK
arch/arm/mach-nuc93x/clock.h
arch/arm/mach-nuc93x/cpu.c
arch/arm/mach-w90x900/clock.h
arch/arm/mach-w90x900/cpu.c

CLK
arch/arm/mach-ux500/clock.c
arch/arm/mach-ux500/clock.h

Array unfolded:
arch/arm/mach-bcmring/core.c
arch/arm/mach-integrator/core.c
arch/arm/mach-integrator/integrator_cp.c
arch/arm/mach-nomadik/clock.c
arch/arm/mach-prima2/clock.c
arch/arm/mach-realview/core.c
arch/arm/mach-versatile/core.c
arch/arm/mach-vexpress/ct-ca9x4.c
arch/arm/mach-vexpress/v2m.c
arch/arm/mach-spear3xx/clock.c
arch/arm/mach-spear6xx/clock.c
arch/arm/mach-pnx4008/clock.c
arch/arm/mach-tegra/tegra2_clocks.c


-- 
Tushar Behera
