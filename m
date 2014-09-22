From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 22 Sep 2014 13:15:21 +0200
Subject: [PATCH v5 01/11] PM / Domains: Add a detach callback to the
 struct dev_pm_domain
In-Reply-To: <1411151264-16245-2-git-send-email-ulf.hansson@linaro.org>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdX7twqW5A1LS-RqoZHRmqZdLVCaACr45GrtyA843iVA_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 8:27 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -619,6 +619,7 @@ extern int dev_pm_put_subsys_data(struct device *dev);
>   */
>  struct dev_pm_domain {
>         struct dev_pm_ops       ops;
> +       void (*detach)(struct device *, bool);

I think it would help to add the parameter names, especially for
the "bool" parameter:

void (*detach)(struct device *dev, bool power_off);

>  };
>
>  /*

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
