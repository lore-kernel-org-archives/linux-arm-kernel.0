From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 25 Dec 2011 09:53:23 +0800
Subject: [PATCH 11/20] ARM: plat-mxc: hook special idle handlers to
 arm_pm_idle
In-Reply-To: <1324288069-21940-12-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-12-git-send-email-nico@fluxnic.net>
Message-ID: <20111225015322.GC8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico,

On Mon, Dec 19, 2011 at 04:47:40AM -0500, Nicolas Pitre wrote:
> ... and remove redundant include of <mach/system.h>.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
>  arch/arm/mach-imx/mm-imx3.c             |    4 ++--
>  arch/arm/mach-imx/pm-imx27.c            |    3 +--
>  arch/arm/mach-mx5/mm.c                  |    2 +-

The hook imx_idle has been removed since v3.2-rc4 as suggested by rmk,
so the context is changed here.

>  arch/arm/mach-mxs/pm.c                  |    3 +--

The mxs is a different sub-architecture/platform than imx/mxc, so it
might be better to split it out.

-- 
Regards,
Shawn

>  arch/arm/plat-mxc/include/mach/common.h |    1 -
>  arch/arm/plat-mxc/include/mach/system.h |    7 +------
>  arch/arm/plat-mxc/system.c              |    1 -
>  7 files changed, 6 insertions(+), 15 deletions(-)
> 
