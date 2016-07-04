From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 Jul 2016 09:54:05 +0200
Subject: [PATCH] clkdev: add devm_of_clk_get()
In-Reply-To: <87y45iz0cs.wl%kuninori.morimoto.gx@renesas.com>
References: <87y45iz0cs.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <7596144.XSxKMDxLKp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 4, 2016 1:04:30 AM CEST Kuninori Morimoto wrote:
> @@ -501,6 +503,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
>  {
>         return ERR_PTR(-ENOENT);
>  }
> +struct clk *devm_of_clk_get(struct device *dev,
> +                           struct device_node *np, int index)
> +{
> +       return ERR_PTR(-ENOENT);
> +}
>  static inline struct clk *of_clk_get_by_name(struct device_node *np,
>                                              const char *name)
>  {
> -- 
> 

This is missing "static inline" as found by the bot.

	Arnd
