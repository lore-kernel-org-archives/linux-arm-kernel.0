From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 13 May 2015 19:29:19 +0200 (CEST)
Subject: [PATCH v2 1/3] input: keyboad: imx: add snvs power key driver
In-Reply-To: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
References: <1431528462-21591-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <953071056.79336.1431538159562.JavaMail.open-xchange@oxbsltgw06.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

looks like a typo in your subject line. keyboard?

> Frank.Li at freescale.com hat am 13. Mai 2015 um 16:47 geschrieben:
>
> [...]
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c
> b/drivers/input/keyboard/snvs_pwrkey.c
> new file mode 100644
> index 0000000..e4c2de3
> --- /dev/null
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -0,0 +1,239 @@
> +/*

a small driver description here would be nice.

> + * Copyright (C) 2015 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> [...]
> +static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
> +{
> [...]
> +
> + pdata->wakeup = !!of_get_property(np, "linux,wakeup", NULL);

of_property_read_bool() ?

> +
> [...]
> +
> + ret = input_register_device(input);
> + if (ret < 0) {
> + dev_err(&pdev->dev, "failed to register input device\n");
> + input_free_device(input);

input_free_device() shouldn't be necessary since you are using
devm_input_allocate_device().

Thanks

Best regards
Stefan
