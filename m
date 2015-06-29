From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Jun 2015 15:10:52 +0200
Subject: [PATCH RFC v2 03/16] PM / Domains: Support IRQ safe PM domains
In-Reply-To: <1435374156-19214-4-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
 <1435374156-19214-4-git-send-email-lina.iyer@linaro.org>
Message-ID: <CAMuHMdUQy7b2UWJVe6oc2r3EpiAur3BChOYWeGY61NYUJNPFow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I forgot a few comments...

On Sat, Jun 27, 2015 at 5:02 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt

> +context, may contain IRQ safe devices. Such domain may only contain only IRQ

Double "only".

> +safe devices or IRQ safe sub-domains.

> @@ -532,15 +608,18 @@ static int pm_genpd_runtime_resume(struct device *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       /* If power.irq_safe, the PM domain is never powered off. */
> -       if (dev->power.irq_safe) {
> +       /*
> +        * As we dont power off a non IRQ safe domain, which holds a

Bogus "a" at the end.

> +        * an IRQ safe device, we dont need to restore power to it.
> +        */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
