From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 18 Oct 2018 10:14:31 -0700
Subject: [PATCH v5 1/3] clk: meson: add emmc sub clock phase delay driver
In-Reply-To: <1539839245-13793-2-git-send-email-jianxin.pan@amlogic.com>
References: <1539839245-13793-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839245-13793-2-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <153988287137.5275.1146335138540290297@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jianxin Pan (2018-10-17 22:07:23)
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 6b96d55..3309d78 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -105,6 +105,18 @@ struct clk_regmap _name = {                                                \
>         },                                                              \
>  };
>  
> +struct meson_clk_phase_delay_data {
> +       struct parm                     phase;
> +       struct parm                     delay;
> +       unsigned int                    delay_step_ps;
> +};
> +
> +static inline struct meson_clk_phase_delay_data *
> +meson_clk_get_phase_delay_data(struct clk_regmap *clk)
> +{
> +       return (struct meson_clk_phase_delay_data *)clk->data;

Is data a void *? If so, please drop the useless cast.

> +}
> +
>  /* clk_ops */
>  extern const struct clk_ops meson_clk_pll_ro_ops;
>  extern const struct clk_ops meson_clk_pll_ops;
