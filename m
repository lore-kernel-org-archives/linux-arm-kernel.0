From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 5 Jun 2016 19:41:57 +0200
Subject: [PATCH 07/34] clk: berlin: Migrate to clk_hw based registration
 and OF APIs
In-Reply-To: <20160601231533.9354-8-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
 <20160601231533.9354-8-stephen.boyd@linaro.org>
Message-ID: <20160605174157.GP4594@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The main drawback of those patches is that they break the alignment
(checkpatch.pl --strict complains).

On 01/06/2016 at 16:15:06 -0700, Stephen Boyd wrote :
> diff --git a/drivers/clk/berlin/berlin2-avpll.h b/drivers/clk/berlin/berlin2-avpll.h
> index a37f5068d299..17e311153b42 100644
> --- a/drivers/clk/berlin/berlin2-avpll.h
> +++ b/drivers/clk/berlin/berlin2-avpll.h
> @@ -19,17 +19,13 @@
>  #ifndef __BERLIN2_AVPLL_H
>  #define __BERLIN2_AVPLL_H
>  
> -struct clk;
> -
>  #define BERLIN2_AVPLL_BIT_QUIRK		BIT(0)
>  #define BERLIN2_AVPLL_SCRAMBLE_QUIRK	BIT(1)
>  
> -struct clk * __init
> -berlin2_avpll_vco_register(void __iomem *base, const char *name,
> +int berlin2_avpll_vco_register(void __iomem *base, const char *name,

This is missing __init.

>  	   const char *parent_name, u8 vco_flags, unsigned long flags);
>  
> -struct clk * __init
> -berlin2_avpll_channel_register(void __iomem *base, const char *name,
> +int berlin2_avpll_channel_register(void __iomem *base, const char *name,

Ditto.

>  		       u8 index, const char *parent_name, u8 ch_flags,
>  		       unsigned long flags);
>  
> diff --git a/drivers/clk/berlin/berlin2-pll.h b/drivers/clk/berlin/berlin2-pll.h
> index 8831ce27ac1e..796874facc4c 100644
> --- a/drivers/clk/berlin/berlin2-pll.h
> +++ b/drivers/clk/berlin/berlin2-pll.h
> @@ -19,8 +19,6 @@
>  #ifndef __BERLIN2_PLL_H
>  #define __BERLIN2_PLL_H
>  
> -struct clk;
> -
>  struct berlin2_pll_map {
>  	const u8 vcodiv[16];
>  	u8 mult;
> @@ -29,8 +27,7 @@ struct berlin2_pll_map {
>  	u8 divsel_shift;
>  };
>  
> -struct clk * __init
> -berlin2_pll_register(const struct berlin2_pll_map *map,
> +int berlin2_pll_register(const struct berlin2_pll_map *map,

Ditto.

>  		     void __iomem *base, const char *name,
>  		     const char *parent_name, unsigned long flags);
>  
-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
