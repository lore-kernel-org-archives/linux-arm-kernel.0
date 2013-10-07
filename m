From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 07 Oct 2013 16:39:02 -0700
Subject: [PATCH] clk: nomadik: fix missing __init on nomadik_src_init
In-Reply-To: <1381168393-31687-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381168393-31687-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131007233902.7445.708@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2013-10-07 10:53:13)
> nomadik_src_init references __initconst sections but lacks an __init
> itself. Add __init to fix the section mismatch.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> Fixing a section mismatch introduced by 
>   "ARM: provide common arch init for DT clocks for v3.13"
> 
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: "arm at kernel.org" <arm@kernel.org>
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
> ---
>  drivers/clk/clk-nomadik.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/clk/clk-nomadik.c b/drivers/clk/clk-nomadik.c
> index ce2d6b3..6a934a5 100644
> --- a/drivers/clk/clk-nomadik.c
> +++ b/drivers/clk/clk-nomadik.c
> @@ -86,7 +86,7 @@ static const struct of_device_id nomadik_src_match[] __initconst = {
>         { /* sentinel */ }
>  };
>  
> -static void nomadik_src_init(void)
> +static void __init nomadik_src_init(void)
>  {
>         struct device_node *np;
>         u32 val;
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
