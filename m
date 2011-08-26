From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Aug 2011 10:18:57 +0200
Subject: [[PATCH v3 0/6] imx soc revision clean up
In-Reply-To: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
References: <1314336923-25162-1-git-send-email-jason.hui@linaro.org>
Message-ID: <20110826081857.GF31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2011 at 01:35:17PM +0800, Jason Liu wrote:
> The patchset make some clean up for the imx soc revision display by
> - introudce the generic function for displaying silicon revision
> - update the imx SoCs to adopt the same usage
> 
> The patchset is based on Fabio's initial commit and I did some update
> 
> V3:
> - fix the mx51TO3/mx31 print information
> V2: Address comments from Sascha
> - Remove the EXPORT_SYMBOL from imx_print_silicon_rev
> - Fix the mx31 print twice issue
> 
> Fabio Estevam (1):
>   ARM: imx: Introduce generic function for displaying silicon revision
> 
> Jason Liu (5):
>   ARM: mx25: Print silicon revision on boot
>   ARM: mx27: Print silicon revision on boot
>   ARM: mx31: use generic function for displaying silicon revision
>   ARM: mx35: use generic function for displaying silicon revision
>   ARM: mx5: use generic function for displaying silicon revision

Applied for next.

Sascha

> 
>  arch/arm/mach-imx/Makefile              |    2 +-
>  arch/arm/mach-imx/clock-imx25.c         |    6 +++
>  arch/arm/mach-imx/clock-imx27.c         |    2 +
>  arch/arm/mach-imx/clock-imx31.c         |    4 +-
>  arch/arm/mach-imx/clock-imx35.c         |    3 +-
>  arch/arm/mach-imx/cpu-imx25.c           |   41 +++++++++++++++++
>  arch/arm/mach-imx/cpu-imx27.c           |   28 +++++------
>  arch/arm/mach-imx/cpu-imx31.c           |   48 +++++++++++---------
>  arch/arm/mach-imx/cpu-imx35.c           |   30 ++++++-------
>  arch/arm/mach-mx5/clock-mx51-mx53.c     |    6 +--
>  arch/arm/mach-mx5/cpu.c                 |   74 +++++++------------------------
>  arch/arm/plat-mxc/cpu.c                 |    9 ++++
>  arch/arm/plat-mxc/include/mach/common.h |    1 +
>  arch/arm/plat-mxc/include/mach/mx25.h   |    4 ++
>  arch/arm/plat-mxc/include/mach/mx3x.h   |   18 +-------
>  15 files changed, 142 insertions(+), 134 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpu-imx25.c
> 
> -- 
> 1.7.4.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
