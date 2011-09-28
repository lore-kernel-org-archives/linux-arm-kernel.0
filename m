From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 28 Sep 2011 14:20:49 +0200
Subject: [PATCH 0/6] Support single zImage for imx3 and imx6
In-Reply-To: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
References: <1317201368-6403-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110928122049.GZ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Sep 28, 2011 at 05:16:02PM +0800, Shawn Guo wrote:
> This series supports the single zImage build for imx3 and imx6.  It's
> based on linux-next with imx6 series applied, and tested on imx35 and
> imx6q.

I'm fine with this series (and the i.MX6 series). I can merge this
series without the last patch now. For the i.MX6 series I think we have
to wait until the prerequisites are merged. Maybe we should merge this
in a second pull request during the merge window.

Sascha

> 
> Sascha Hauer (1):
>       arm/imx: merge i.MX3 and i.MX6
> 
> Shawn Guo (5):
>       arm/imx: merge mm-imx35.c into mm-imx31.c
>       arm/imx: rename mm-imx31.c to mm-imx3.c
>       arm/imx: change mxc_init_l2x0() to an imx31/35 specific call
>       arm/imx: remove cpu_is_xxx() from arch_idle()
>       arm/imx: remove cpu_is_xxx() check from __imx_ioremap()
> 
>  arch/arm/Makefile                       |    3 +-
>  arch/arm/mach-imx/Kconfig               |    7 +-
>  arch/arm/mach-imx/Makefile              |    5 +-
>  arch/arm/mach-imx/Makefile.boot         |   10 +-
>  arch/arm/mach-imx/cache-l2x0.c          |   56 -------
>  arch/arm/mach-imx/mm-imx3.c             |  256 +++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/mm-imx31.c            |   91 -----------
>  arch/arm/mach-imx/mm-imx35.c            |  109 -------------
>  arch/arm/mach-mx5/mm.c                  |    6 +
>  arch/arm/mach-mx5/pm-imx5.c             |    3 +-
>  arch/arm/mm/Kconfig                     |    4 +-
>  arch/arm/plat-mxc/Kconfig               |   18 +--
>  arch/arm/plat-mxc/include/mach/common.h |    2 +
>  arch/arm/plat-mxc/include/mach/io.h     |   22 +--
>  arch/arm/plat-mxc/include/mach/system.h |   35 +----
>  arch/arm/plat-mxc/system.c              |    3 +
>  16 files changed, 300 insertions(+), 330 deletions(-)
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
