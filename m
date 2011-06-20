From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 20 Jun 2011 22:50:55 +0800
Subject: [PATCH 6/6] ARM: mxc: clean up imx-dma device registration
In-Reply-To: <1307950645-26529-7-git-send-email-shawn.guo@linaro.org>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
	<1307950645-26529-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110620145054.GA24184@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

Any comment on this one?

Regards,
Shawn

On Mon, Jun 13, 2011 at 03:37:25PM +0800, Shawn Guo wrote:
> The patch follows the implementation of gpio-mxc device registration
> to break the concentrated imx-dma device registration into soc
> specific setup function.  Then we can avoid the churn of "#ifdef"
> and the cpu_is_mx checking on such a long list, which makes no sense,
> considering more soc supports need to be added and we need to support
> single image for multiple socs in the long run.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/mm-imx21.c                    |    3 +
>  arch/arm/mach-imx/mm-imx25.c                    |   26 +++
>  arch/arm/mach-imx/mm-imx27.c                    |    3 +
>  arch/arm/mach-imx/mm-imx31.c                    |   24 +++
>  arch/arm/mach-imx/mm-imx35.c                    |   44 +++++
>  arch/arm/mach-mx5/mm.c                          |   23 +++
>  arch/arm/plat-mxc/devices.c                     |   16 ++-
>  arch/arm/plat-mxc/devices/platform-imx-dma.c    |  202 ++---------------------
>  arch/arm/plat-mxc/include/mach/devices-common.h |    6 +
>  9 files changed, 157 insertions(+), 190 deletions(-)
> 
