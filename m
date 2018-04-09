From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 09 Apr 2018 14:03:45 +0200
Subject: [PATCH v4 2/7] clk: meson: migrate to
 devm_of_clk_add_hw_provider API
In-Reply-To: <20180408031938.153474-3-yixun.lan@amlogic.com>
References: <20180408031938.153474-1-yixun.lan@amlogic.com>
 <20180408031938.153474-3-yixun.lan@amlogic.com>
Message-ID: <1523275425.2764.20.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-04-08 at 11:19 +0800, Yixun Lan wrote:
> There is a protential memory leak, as of_clk_del_provider is
> never called if of_clk_add_hw_provider has been executed.
> Fix this by using devm variant API.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Please make this the 1st patch of the series and add the proper fixes tag.

> ---
>  drivers/clk/meson/meson-aoclk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
> index 14862c22e20d..14a1e46a4de6 100644
> --- a/drivers/clk/meson/meson-aoclk.c
> +++ b/drivers/clk/meson/meson-aoclk.c
> @@ -78,6 +78,6 @@ int meson_aoclkc_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> -	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>  		(void *) data->hw_data);
>  }
