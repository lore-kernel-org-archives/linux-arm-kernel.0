From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Thu, 09 Nov 2017 12:50:04 +0100
Subject: [PATCH 2/3] EDAC: ti: add support for TI keystone and DRA7xx EDAC
In-Reply-To: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
References: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
 <1510087139-21885-3-git-send-email-t-kristo@ti.com>
Message-ID: <1510228204.3471.44.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-07 at 22:38 +0200, Tero Kristo wrote:
> +       if (edac_mc_add_mc(mci)) {
> +               pr_err("%s: Failed to register mci.\n", __func__);
> +               return -ENOMEM;
This leaks the allocated mci structure in the error case.

> +       }
> +
> +       /* add EMIF ECC error handler */
> +       error_irq = platform_get_irq(pdev, 0);
> +       if (!error_irq) {
> +               dev_err(dev, "DDR3 EDAC irq number not defined\n");
> +               return ret;
This leaves the mc registered in the error case.

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
