From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 17 Oct 2013 15:15:43 -0700
Subject: [PATCH v4 02/15] clk: tegra: simplify periph clock data
In-Reply-To: <1382013526-12800-3-git-send-email-pdeschrijver@nvidia.com>
References: <1382013526-12800-1-git-send-email-pdeschrijver@nvidia.com>
 <1382013526-12800-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAL1qeaGg+XdCWSp4yjWTFxXjhj8a+_dFwpT+B_H+GQ_CWZ50-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> @@ -2346,6 +2247,9 @@ static void __init tegra114_clock_init(struct device_node *np)
>         if (tegra114_osc_clk_init(clk_base) < 0)
>                 return;
>
> +       if (tegra_clk_set_periph_banks(5) < 0)

Maybe it would be better to have a #define for this (e.g.
TEGRAxxx_CLK_PERIPH_BANKS)?  Same goes for t20 and t30.

>  /* Global data of Tegra CPU CAR ops */
>  static struct tegra_cpu_car_ops dummy_car_ops;
>  struct tegra_cpu_car_ops *tegra_cpu_car_ops = &dummy_car_ops;
>
> +int *periph_clk_enb_refcnt;

This changes seems unrelated.  Perhaps it should go in the one that
makes the common periph_clk_enb_refcnt?

Thanks,
Andrew
