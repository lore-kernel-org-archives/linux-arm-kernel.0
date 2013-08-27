From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 Aug 2013 16:16:53 -0700
Subject: [PATCH RFC v2 15/16] clk: vt8500: remove call to of_clk_init
In-Reply-To: <1377638890-371-16-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-16-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130827231653.8231.41009@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2013-08-27 14:28:09)
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove it from corresponding drivers/clk code.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/clk/clk-vt8500.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
> index 82306f5..218d7ba 100644
> --- a/drivers/clk/clk-vt8500.c
> +++ b/drivers/clk/clk-vt8500.c
> @@ -701,6 +701,4 @@ void __init vtwm_clk_init(void __iomem *base)
>                 return;
>  
>         pmc_base = base;
> -
> -       of_clk_init(NULL);
>  }
> -- 
> 1.7.2.5
