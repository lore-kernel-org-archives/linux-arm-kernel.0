From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 13:44:38 +0530
Subject: [PATCH v2 1/3] ARM: davinci: hawk: use gpio descriptor for mmc
 pins
In-Reply-To: <20161124150454.23899-2-ahaslam@baylibre.com>
References: <20161124150454.23899-1-ahaslam@baylibre.com>
 <20161124150454.23899-2-ahaslam@baylibre.com>
Message-ID: <71d110ec-486b-5f26-1566-0fb9de93227e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 November 2016 08:34 PM, Axel Haslam wrote:
> Currently the mmc driver is polling the gpio to know if the
> card was removed.
> 
> By using a gpio descriptor instead of the platform callbacks,
> the driver will be able to register the gpio using the mmc core
> API's designed for this purpose.

s/API's/APIs

> 
> This has the advantage that an irq will be registered, and
> polling is no longer needed. Also, a dependency on platform
> callbacks is removed for this board.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-omapl138-hawk.c | 42 ++++++++---------------------
>  1 file changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
> index a4e8726..a2966d3 100644
> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> @@ -15,6 +15,7 @@
>  #include <linux/gpio.h>
>  #include <linux/platform_data/gpio-davinci.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/gpio/machine.h>

Moved this include to below linux/gpio.h

Applied to v4.10/soc

Thanks,
Sekhar
