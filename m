From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 21 Apr 2016 15:04:11 +0200
Subject: [PATCH 5/8] cpufreq: shmobile: Use generic platdev driver
In-Reply-To: <ab29df38f70453e67089e3f3dbb9085336eef1c2.1461228081.git.viresh.kumar@linaro.org>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <ab29df38f70453e67089e3f3dbb9085336eef1c2.1461228081.git.viresh.kumar@linaro.org>
Message-ID: <CAMuHMdUnzgr==S86Wiz0fGk2gSWW2=j+maiq3=3x9Ozy7AoOZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Thu, Apr 21, 2016 at 10:43 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -29,6 +29,18 @@ static const struct of_device_id machines[] = {
>         { .compatible = "samsung,exynos5800", },
>  #endif
>

I think an #ifdef CONFIG_ARCH_RENESAS block wouldn't hurt, likewise
for the other SoCs.
Soon you'll have this file filled with lots of compatible values for random\
SoCs...

> +       { .compatible = "renesas,emev2", },
> +       { .compatible = "renesas,r7s72100", },
> +       { .compatible = "renesas,r8a73a4", },
> +       { .compatible = "renesas,r8a7740", },
> +       { .compatible = "renesas,r8a7778", },
> +       { .compatible = "renesas,r8a7779", },
> +       { .compatible = "renesas,r8a7790", },
> +       { .compatible = "renesas,r8a7791", },
> +       { .compatible = "renesas,r8a7793", },
> +       { .compatible = "renesas,r8a7794", },
> +       { .compatible = "renesas,sh73a0", },
> +
>         { .compatible = "rockchip,rk2928", },
>         { .compatible = "rockchip,rk3066a", },
>         { .compatible = "rockchip,rk3066b", },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
