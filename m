From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 29 May 2017 09:57:49 +0200
Subject: [PATCH 1/1] clk: meson: meson8b: mark clk81 as critical
In-Reply-To: <20170504183201.13175-2-martin.blumenstingl@googlemail.com>
References: <20170504183201.13175-1-martin.blumenstingl@googlemail.com>
 <20170504183201.13175-2-martin.blumenstingl@googlemail.com>
Message-ID: <0efb9498-2806-8042-b73e-201de6a458cb@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2017 08:32 PM, Martin Blumenstingl wrote:
> Disabling clk81 results in an immediate freeze of the whole system. This
> can happen "accidentally" when the last child-clock of clk81 is disabled
> (in this case the common clock framework also disables clk81, even if it
> was only enabled indirectly before).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index e9985503165c..bfd1690724de 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -399,7 +399,7 @@ struct clk_gate meson8b_clk81 = {
>  		.ops = &clk_gate_ops,
>  		.parent_names = (const char *[]){ "mpeg_clk_div" },
>  		.num_parents = 1,
> -		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),
> +		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED | CLK_IS_CRITICAL),
>  	},
>  };
>  
> 

Hi Martin,

I applied the patch resent by Jerome,

Thanks,
Neil
