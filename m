From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 15 Apr 2014 12:43:55 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW1jOiBtbWNpOiBzd2l0Y2ggdGhlIGRyaXZlciB0byB1?=
 =?UTF-8?B?c2luZyBncGlvIGRlc2NyaXB0b3Jz?=
In-Reply-To: <1397550786-8146-1-git-send-email-linus.walleij@linaro.org>
References: <1397550786-8146-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1397551435.309400197@f243.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 15 Apr 2014 10:33:06 +0200 ?? Linus Walleij <linus.walleij@linaro.org>:
> The next step in modernization of GPIO is to let drivers handle
> descriptors rather than integer numbers representing GPIO pins,
> akin to how clocks or regulators are already handled today.
> 
> This patch makes the MMCI driver use GPIO descriptos in the
> core code with fallback code using the platform data if that
> is not possible. After all platforms with MMCI have been
> migrated to use descriptors, the platform data entries for
> GPIO pins can be removed.
> 
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Russell,Ulf: there is no hurry to do these changes (only used
> for my very corner-case MMCI PL181 experiments) but it's the
> desired direction to use descriptors for GPIOs going forward.
> I can rebase this on top of Ulf's patch stack any time, no
> problem.
> ---
...
>  static void mmci_dt_populate_generic_pdata(struct device_node *np,
> -					struct mmci_platform_data *pdata)
> +					   struct mmci_platform_data *pdata)
>  {
>  	int bus_width = 0;
>  
> -	pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
> -	pdata->gpio_cd = of_get_named_gpio(np, "cd-gpios", 0);
> -
>  	if (of_get_property(np, "cd-inverted", NULL))
>  		pdata->cd_invert = true;

You could even eliminate "cd-inverted" property for DT case.

---
