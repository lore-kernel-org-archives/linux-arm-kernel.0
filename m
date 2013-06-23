From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 23 Jun 2013 21:23:03 +0200
Subject: [PATCH v3 1/5] drivers: bus: imx-weim: Remove private driver data
In-Reply-To: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
References: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130623192303.GO32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 11:48:14AM +0400, Alexander Shiyan wrote:
> Driver uses only probe function so no reason to keep variables
> in private driver data.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/bus/imx-weim.c | 41 ++++++++++++++---------------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 349f14e..0c0e6fe 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -12,11 +12,6 @@
>  #include <linux/io.h>
>  #include <linux/of_device.h>
>  
> -struct imx_weim {
> -	void __iomem *base;
> -	struct clk *clk;
> -};

I don't know how others see it, but I would keep the private data now
that it's there already. We don't know what it's good for in the future
and it doesn't hurt.

This is no strong opinion though since it always can be added back when
it's really needed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
