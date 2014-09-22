From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 22 Sep 2014 13:12:16 +0200
Subject: [PATCH v5 04/11] PM / Domains: Add APIs to attach/detach a PM
 domain for a device
In-Reply-To: <1411151264-16245-5-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdVAoM+z07Scni7iUDcqupJYuMqDDFPAccCA3vR0jqrbBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 8:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c

> @@ -82,3 +84,53 @@ int dev_pm_put_subsys_data(struct device *dev)
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
> +
> +/**
> + * dev_pm_domain_attach - Attach a device to its PM domain.
> + * @dev: Device to attach.
> + * @power_on: Used to indicate whether we should power on the device.
> + *
> + * The @dev may only be attached to a single PM domain. By iterating through
> + * the available alternatives we try to find a valid PM domain for the device.
> + * As attachement succeeds, the ->detach() callback in the struct dev_pm_domain

attachment

> + * should be assigned by the corresponding attach function.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
