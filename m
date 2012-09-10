From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon, 10 Sep 2012 10:17:17 +0200
Subject: [PATCH 1/2] gpio/twl4030: get platform data from device tree
In-Reply-To: <504A2FF2.7070607@ti.com>
References: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch>
 <1346831186-29947-2-git-send-email-florian.vaussard@epfl.ch>
 <504A2FF2.7070607@ti.com>
Message-ID: <504DA20D.7020903@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Benoit,

Le 07/09/2012 19:33, Benoit Cousson a ?crit :
> Hi Florian,
>
> I've just noticed that this patch is reporting some CHECK issues.
>
> d1f5052 - gpio/twl4030: get platform data from device tree
> CHECK: Alignment should match open parenthesis
> #66: FILE: drivers/gpio/gpio-twl4030.c:412:
> +	of_property_read_u32(dev->of_node, "ti,debounce",
> +				&omap_twl_info->debounce);
>
> CHECK: Alignment should match open parenthesis
> #68: FILE: drivers/gpio/gpio-twl4030.c:414:
> +	of_property_read_u32(dev->of_node, "ti,mmc-cd",
> +				(u32 *)&omap_twl_info->mmc_cd);
>
> CHECK: Alignment should match open parenthesis
> #70: FILE: drivers/gpio/gpio-twl4030.c:416:
> +	of_property_read_u32(dev->of_node, "ti,pullups",
> +				&omap_twl_info->pullups);
>
> CHECK: Alignment should match open parenthesis
> #72: FILE: drivers/gpio/gpio-twl4030.c:418:
> +	of_property_read_u32(dev->of_node, "ti,pulldowns",
> +				&omap_twl_info->pulldowns);
>
> CHECK: Alignment should match open parenthesis
> +				pdata->pullups, pdata->pulldowns,
>
> CHECK: Alignment should match open parenthesis
> #139: FILE: drivers/gpio/gpio-twl4030.c:479:
> +		dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
> +				pdata->debounce, pdata->mmc_cd,
>
> total: 0 errors, 0 warnings, 6 checks, 118 lines checked
>
>
> I fixed them since it was trivial, but next time you should ensure that the patch pass checkpatch before posting.

Sorry for these errors. I however checked my patches before submitting, 
and had no such warnings. I redone, and remarked that these warnings 
appear only with the "--strict" option, which is not enabled by default. 
Is this the recommended  guideline? Thus why not enabling it by default?

>
> Just let me know if you have any issue with the following update.

I will test, but should not have any issue with your fix.

Thank you very much for fixing my patch, I send you a virtual chocolate 
from Switzerland!

Regards,
Florian
