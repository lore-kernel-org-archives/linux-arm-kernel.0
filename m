From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Aug 2012 11:12:55 +0200
Subject: [PATCH 1/6] ARM: dove: unify clock setup
In-Reply-To: <1344255815-4457-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344255815-4457-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344255815-4457-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20120811091255.GA31809@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian

> -static void __init clk_init(void)
> +static void __init dove_clk_init(void)
>  {
>  	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
> -				       get_tclk());
> +				       dove_tclk);
>  
>  	orion_clkdev_init(tclk);
> +
> +	/* Ensure tclk is always clocked */
> +	clk_prepare_enable(tclk);
>  }

"ticking" would be better than clocked. 

Since this is a root fixed clock, is it necessary to prepare_enable()
it? I think prepare and enable become NOPs in this situation.

    Andrew
