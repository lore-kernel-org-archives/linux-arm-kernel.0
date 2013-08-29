From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Aug 2013 15:42:26 +0200
Subject: [PATCH RFC v2 15/16] clk: vt8500: remove call to of_clk_init
In-Reply-To: <1377638890-371-16-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-16-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201308291542.26480.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 August 2013, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove it from corresponding drivers/clk code.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

This looks suspicious: of_clk_init must be called after assigning pmc_base
in this driver. I think you should better do the same thing you did for
highbank and move the initialization into the clk driver.

	Arnd
