From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Apr 2016 13:04:23 +0200
Subject: [PATCH] ARM: mv78xx0: Remove CLK_IS_ROOT
In-Reply-To: <1461116404-3285-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Tue, 19 Apr 2016 18:40:04 -0700")
References: <1461116404-3285-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <871t5ruxc8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,
 
 On mer., avril 20 2016, Stephen Boyd <sboyd@codeaurora.org> wrote:

> This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> CLK_IS_ROOT", 2016-02-02) so remove it.
>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Applied on mvebu/soc

(I fixed the email format for Jason: the closing angle bracket was
missing)

Thanks,

Gregory
> ---
>  arch/arm/mach-mv78xx0/common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
> index 99cc93900a24..45a05207b418 100644
> --- a/arch/arm/mach-mv78xx0/common.c
> +++ b/arch/arm/mach-mv78xx0/common.c
> @@ -168,8 +168,7 @@ static struct clk *tclk;
>  
>  static void __init clk_init(void)
>  {
> -	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
> -				       get_tclk());
> +	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, 0, get_tclk());
>  
>  	orion_clkdev_init(tclk);
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
