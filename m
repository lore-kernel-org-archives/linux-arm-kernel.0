From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2016 16:18:20 +0000
Subject: [PATCH] ARM: spear: Fix error handling
In-Reply-To: <20161029135839.6388-1-christophe.jaillet@wanadoo.fr>
References: <20161029135839.6388-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161031161820.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the spear or arm-soc guys to deal with...

On Sat, Oct 29, 2016 at 03:58:39PM +0200, Christophe JAILLET wrote:
> 'clk_get_sys()' returns an error pointer in case of error, not NULL. So
> test it with IS_ERR.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/arm/mach-spear/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 9ccffc1d0f28..4878ba90026d 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -233,7 +233,7 @@ void __init spear_setup_of_timer(void)
>  	}
>  
>  	gpt_clk = clk_get_sys("gpt0", NULL);
> -	if (!gpt_clk) {
> +	if (IS_ERR(gpt_clk)) {
>  		pr_err("%s:couldn't get clk for gpt\n", __func__);
>  		goto err_iomap;
>  	}
> -- 
> 2.9.3
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
