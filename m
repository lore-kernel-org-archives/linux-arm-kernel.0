From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 28 Apr 2015 09:45:54 +0200
Subject: [PATCH v3 1/3] mfd: provide RTC resource in MT6397 MFD
In-Reply-To: <1430206556-18254-2-git-send-email-eddie.huang@mediatek.com>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-2-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150428074554.GZ19431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Apr 28, 2015 at 03:35:54PM +0800, Eddie Huang wrote:
> Provide MT6397 RTC interrupt, base address, and register in
> MT6397 MFD.
> 
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 09bc780..08cfbd1 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -21,9 +21,27 @@
>  #include <linux/mfd/mt6397/core.h>
>  #include <linux/mfd/mt6397/registers.h>
>  
> +#define MT6397_RTC_BASE		0xe000
> +#define MT6397_RTC_SIZE		0x3e
> +
> +static const struct resource mt6397_rtc_resources[] = {
> +	{
> +		.start = MT6397_RTC_BASE,
> +		.end   = MT6397_RTC_BASE + MT6397_RTC_SIZE,
> +		.flags  = IORESOURCE_MEM,
It's definitly a matter of taste if you align the rhs here, but if you
do, do it consitently. That is, either make sure that all equal signs
are in a single column (at least per struct resource), or use a single
space between variable name and =.

If you want to hear my personal preference: I always use a single space.
As if you have to add
	.somelongvariablename = somevalue

you have to touch all other lines, too, which is ugly.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
