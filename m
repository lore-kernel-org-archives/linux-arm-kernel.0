From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Mar 2016 08:38:27 +0700
Subject: [PATCH] ARM: spear: fix check of clk_get_sys() return value
In-Reply-To: <1457393426-14679-1-git-send-email-vz@mleia.com>
References: <1457393426-14679-1-git-send-email-vz@mleia.com>
Message-ID: <20160308013827.GA13153@vireshk-mac-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-03-16, 01:30, Vladimir Zapolskiy wrote:
> The clk_get_sys() function returns either a valid pointer to
> struct clk or ERR_PTR() error value, this makes invalid a check for
> NULL on error path, fix it.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  arch/arm/mach-spear/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 9ccffc1..4878ba9 100644
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
