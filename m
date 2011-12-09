From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 9 Dec 2011 09:05:36 +0800
Subject: [PATCH v2] arm/imx6: add restart support for imx6q
In-Reply-To: <1323066734-29994-1-git-send-email-shawn.guo@linaro.org>
References: <1323066734-29994-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111209010535.GI7913@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I just put the patch into the tracking system as 7198/1.  Please let
me know if any problem.

Regards,
Shawn

On Mon, Dec 05, 2011 at 02:32:14PM +0800, Shawn Guo wrote:
> The restart support was missed from the initial imx6q submission.
> The mxc_restart() does not work for imx6q.  Instead, this patch adds
> the restart for imx6q.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Changes since v1:
>  * Fall into soft_restart in case that iomap for wdog_base fails
> 
>  arch/arm/mach-imx/clock-imx6q.c         |    2 -
>  arch/arm/mach-imx/mach-imx6q.c          |   35 ++++++++++++++++++++++++++++++-
>  arch/arm/mach-imx/src.c                 |   23 ++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/common.h |    1 +
>  4 files changed, 58 insertions(+), 3 deletions(-)
