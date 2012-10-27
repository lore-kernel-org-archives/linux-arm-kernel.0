From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 27 Oct 2012 17:10:18 +0200
Subject: [PATCH 3/4] mfd: ab8500: add devicetree support for charger
In-Reply-To: <1351146654-9110-4-git-send-email-rajanikanth.hv@stericsson.com>
References: <1351146654-9110-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1351146654-9110-4-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <508BF95A.5000608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 08:30 AM, Rajanikanth H.V wrote:
> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
> 
> This patch adds device tree support for ab8500-charger
> driver
> 
> Signed-off-by: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
[...]
> diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
> index 78a730c..956943e 100644
> --- a/drivers/power/ab8500_charger.c
> +++ b/drivers/power/ab8500_charger.c
> @@ -23,6 +23,8 @@
>  #include <linux/err.h>
>  #include <linux/workqueue.h>
>  #include <linux/kobject.h>
> +#include <linux/of.h>
> +#include <linux/mfd/core.h>
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500-bm.h>
> @@ -183,7 +185,6 @@ struct ab8500_charger_usb_state {
>   * @autopower		Indicate if we should have automatic pwron after pwrloss
>   * @parent:		Pointer to the struct ab8500
>   * @gpadc:		Pointer to the struct gpadc
> - * @pdata:		Pointer to the abx500_charger platform data
>   * @bat:		Pointer to the abx500_bm platform data
>   * @flags:		Structure for information about events triggered
>   * @usb_state:		Structure for usb stack information
> @@ -218,9 +219,9 @@ struct ab8500_charger {
>  	int vbat;
>  	int old_vbat;
>  	bool autopower;
> +	bool autopower_cfg;

autopower_cfg should be added in the description of the struct members
as well.

--
Francesco
