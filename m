From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 25 May 2017 14:33:08 -0700
Subject: [PATCH v4 03/11] clk: bcm: Add clocks for Stingray SOC
In-Reply-To: <1495454307-23464-4-git-send-email-anup.patel@broadcom.com>
References: <1495454307-23464-1-git-send-email-anup.patel@broadcom.com>
 <1495454307-23464-4-git-send-email-anup.patel@broadcom.com>
Message-ID: <149574798866.52617.17864487502272102012@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anup,

Quoting Anup Patel (2017-05-22 04:58:19)
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>

Are all of those headers really needed?

> +CLK_OF_DECLARE(sr_genpll3_clk, "brcm,sr-genpll3",
> +                       sr_genpll3_clk_init);

Why use CLK_OF_DECLARE here? You've got a proper platform driver here.

Regards,
Mike
