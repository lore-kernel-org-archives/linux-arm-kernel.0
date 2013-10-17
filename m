From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 17 Oct 2013 15:26:20 -0700
Subject: [PATCH v4 03/15] clk: tegra: common periph_clk_enb_refcnt and clks
In-Reply-To: <1382013526-12800-4-git-send-email-pdeschrijver@nvidia.com>
References: <1382013526-12800-1-git-send-email-pdeschrijver@nvidia.com>
 <1382013526-12800-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAL1qeaFrm50m0a3csY=04MNQENM_DY5fgBrq5bdsm8dHnLj1gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

>  static void __init tegra30_clock_init(struct device_node *np)
>  {
>         struct device_node *node;
> -       int i;
>
>         clk_base = of_iomap(np, 0);
>         if (!clk_base) {
> @@ -1916,8 +1910,11 @@ static void __init tegra30_clock_init(struct device_node *np)
>                 BUG();
>         }
>
> -       if (tegra_clk_set_periph_banks(5) < 0)
> +       clks = tegra_clk_init(clk_max, 5);
> +       if (!clks) {
> +               WARN_ON(1);

Really minor nit: it seems strange that we WARN here for t30, but not
for t114 or t20.

Thanks,
Andrew
