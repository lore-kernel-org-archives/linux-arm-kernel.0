From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 22 Jul 2011 09:39:23 +0800
Subject: [PATCH 1/6] mc13783: add power button support
In-Reply-To: <1311261006-28048-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1311261006-28048-1-git-send-email-philippe.retornaz@epfl.ch>
	<1311261006-28048-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20110722013922.GC26837@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 05:10:01PM +0200, Philippe R?tornaz wrote:
> This adds support for the power-on buttons of MC13783 PMIC.
> This is done using a misc input device.
> 
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
> ---
>  drivers/input/misc/Kconfig             |   10 +
>  drivers/input/misc/Makefile            |    1 +
>  drivers/input/misc/mc13783-pwrbutton.c |  288 ++++++++++++++++++++++++++++++++
>  drivers/mfd/mc13xxx-core.c             |    4 +
>  include/linux/mfd/mc13783.h            |    1 +
>  include/linux/mfd/mc13xxx.h            |   17 ++
>  6 files changed, 321 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/misc/mc13783-pwrbutton.c
> 
[...]
> diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
> index 7e4d44b..573e16b 100644
> --- a/drivers/mfd/mc13xxx-core.c
> +++ b/drivers/mfd/mc13xxx-core.c
> @@ -778,6 +778,10 @@ err_revision:
>  		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
>  				pdata->leds, sizeof(*pdata->leds));
>  
> +	if (pdata->buttons)
> +		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
> +				pdata->buttons, sizeof(*pdata->buttons));
> +

I do not see pdata has been checked for not being a NULL pointer
before using it in this function.  I know it's not you who started
it, but since you have been there, I'm wondering if you can give
it a fix.

-- 
Regards,
Shawn
