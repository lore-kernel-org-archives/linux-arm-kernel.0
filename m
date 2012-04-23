From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Apr 2012 09:59:57 +0800
Subject: [PATCH 4/5] ARM: mxs: do not add dma device by default
In-Reply-To: <1334753197-12032-5-git-send-email-b29396@freescale.com>
References: <1334753197-12032-1-git-send-email-b29396@freescale.com>
 <1334753197-12032-5-git-send-email-b29396@freescale.com>
Message-ID: <20120423015953.GH26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 08:46:36PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> This will cause conflict when dt is enabled.
> So let each platform add dma devices respectively.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  arch/arm/mach-mxs/devices-mx23.h                |    2 ++
>  arch/arm/mach-mxs/devices-mx28.h                |    2 ++
>  arch/arm/mach-mxs/devices/platform-dma.c        |    3 +--
>  arch/arm/mach-mxs/include/mach/devices-common.h |    3 +++
>  arch/arm/mach-mxs/mach-apx4devkit.c             |    1 +
>  arch/arm/mach-mxs/mach-m28evk.c                 |    1 +
>  arch/arm/mach-mxs/mach-mx23evk.c                |    1 +
>  arch/arm/mach-mxs/mach-stmp378x_devb.c          |    1 +
>  arch/arm/mach-mxs/mach-tx28.c                   |    1 +
>  9 files changed, 13 insertions(+), 2 deletions(-)
> 
I think instead of asking every board file to add dma device
explicitly, we probably need to do something similar to imx, having
functions imx23_soc_init and imx28_soc_init which will only be called
for non-dt boot, and adding devices like dma, gpio there.

Regards,
Shawn
