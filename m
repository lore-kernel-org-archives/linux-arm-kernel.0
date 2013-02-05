From: tony@atomide.com (Tony Lindgren)
Date: Mon, 4 Feb 2013 16:46:38 -0800
Subject: [PATCH v8 10/12] pinctrl: single: support generic pinconf
In-Reply-To: <1359825953-15663-11-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-11-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130205004638.GC25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:32]:
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -22,8 +22,10 @@
>  
>  #include <linux/pinctrl/pinctrl.h>
>  #include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf-generic.h>
>  
>  #include "core.h"
> +#include "pinconf.h"
>  
>  #define DRIVER_NAME			"pinctrl-single"
>  #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"

I'm getting the following with this patch applied:

"pinconf_generic_dump_config" [drivers/pinctrl/pinctrl-single.ko] undefined!

This is with the following options:

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
CONFIG_PINCTRL_SINGLE=m

The includes look right, probably you're just missing
EXPORT_SYMBOL(pinconf_generic_dump_config) in the patch
adding pinconf_generic_dump_config?

Regards,

Tony
