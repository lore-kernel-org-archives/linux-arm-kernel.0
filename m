From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 28 May 2015 15:16:29 +0200
Subject: [PATCH] clk: at91: fix h32mx prototype inclusion in pmc header
In-Reply-To: <1432818441-17278-1-git-send-email-nicolas.ferre@atmel.com>
References: <1432818441-17278-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150528151629.5606bda3@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 May 2015 15:07:21 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Trivial fix that prevents to compile this pmc clock driver if h32mx clock is
> present but smd clock isn't.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> Fixes: bcc5fd49a0fd ("clk: at91: add a driver for the h32mx clock")
> Cc: <stable@vger.kernel.org> # 3.18+
> ---
>  drivers/clk/at91/pmc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 69abb08cf146..eb8e5dc9076d 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -121,7 +121,7 @@ extern void __init of_at91sam9x5_clk_smd_setup(struct device_node *np,
>  					       struct at91_pmc *pmc);
>  #endif
>  
> -#if defined(CONFIG_HAVE_AT91_SMD)
> +#if defined(CONFIG_HAVE_AT91_H32MX)
>  extern void __init of_sama5d4_clk_h32mx_setup(struct device_node *np,
>  					      struct at91_pmc *pmc);
>  #endif



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
