From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Oct 2011 20:56:23 +0900
Subject: [RESEND][PATCH V2 0/2] Add a common macro for creating struct
	clk_lookup entries
In-Reply-To: <1318333530-7023-1-git-send-email-padma.v@samsung.com>
References: <1318333530-7023-1-git-send-email-padma.v@samsung.com>
Message-ID: <057301cc880c$cc7f1f50$657d5df0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> From: Padmavathi Venna <padma.v@samsung.com>
> 
> This patchset consolidates the macro that creates 'struct clk_lookup'
> entries by introducing a common macro 'CLKDEV_INIT' as suggested by
> Russell King. Few of the platforms have been modified to use this new
macro.
> 
> I have done the replacement by using python script. I have only build
tested
> for below platforms with existing defconfigs.
> 
> Changes since V1:
> - Removed "&" and "," from the CLKDEV_INIT macro.
> - Replaced the platform specific macros to use the new CLKDEV_INIT macro.
> - Rebased the patches on the latest master branch of Linux-Next.
> 
> Padmavathi Venna (2):
>   ARM: CLKDEV: Add Common Macro for clk_lookup
>   ARM: Using CLKDEV_INIT for creating clk_lookup instance
> 
>  arch/arm/mach-davinci/board-dm646x-evm.c |    5 +-
>  arch/arm/mach-davinci/clock.h            |    7 --
>  arch/arm/mach-davinci/da830.c            |  101 ++++++++++----------
>  arch/arm/mach-davinci/da850.c            |   95 ++++++++++----------
>  arch/arm/mach-davinci/dm355.c            |   87 +++++++++---------
>  arch/arm/mach-davinci/dm365.c            |  113 +++++++++++-----------
>  arch/arm/mach-davinci/dm644x.c           |   77 ++++++++--------
>  arch/arm/mach-davinci/dm646x.c           |   81 ++++++++--------
>  arch/arm/mach-davinci/tnetv107x.c        |  133
+++++++++++++-------------
>  arch/arm/mach-ep93xx/clock.c             |   61 ++++++-------
>  arch/arm/mach-imx/clock-imx1.c           |   38 +++-----
>  arch/arm/mach-imx/clock-imx21.c          |   91 +++++++++----------
>  arch/arm/mach-imx/clock-imx25.c          |   79 +++++++---------
>  arch/arm/mach-imx/clock-imx27.c          |  111 ++++++++++------------
>  arch/arm/mach-imx/clock-imx31.c          |  103 ++++++++++-----------
>  arch/arm/mach-imx/clock-imx35.c          |  117 +++++++++++------------
>  arch/arm/mach-lpc32xx/clock.c            |   75 +++++++--------
>  arch/arm/mach-mx5/clock-mx51-mx53.c      |  149
++++++++++++++--------------
> --
>  arch/arm/mach-mxs/clock-mx23.c           |   39 +++-----
>  arch/arm/mach-mxs/clock-mx28.c           |   71 +++++++--------
>  arch/arm/mach-tcc8k/clock.c              |  107 ++++++++++-----------
>  include/linux/clkdev.h                   |    7 ++
>  22 files changed, 838 insertions(+), 909 deletions(-)
> 
> --
> 1.7.4.4

(Cc'ed Arnd)

Looks ok to me and on Samsung stuff also.

If required,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Russell,
Maybe as you know, this is required on upcoming Samsung stuff. Actually it's
just change/consolidate on other stuff but add on Samsung stuff. So if
you're ok, how about sending this to upstream via arm-soc or your tree in
this merge window?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
