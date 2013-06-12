From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 11 Jun 2013 18:07:44 -0700
Subject: [PATCH] MAINTAINERS: make drivers/clk entry match subdirs
In-Reply-To: <1370447430-3466-1-git-send-email-swarren@wwwdotorg.org>
References: <1370447430-3466-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130612010744.8816.17447@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-06-05 08:50:30)
> From: Stephen Warren <swarren@nvidia.com>
> 
> Modify the drivers/clk MAINTAINERS entry so that it matches the entire
> drivers/clk tree, with the exception of clkdev.c which has a separate
> entry. Make a similar change to pick up all clk-related header files.
> 
> This causes get_maintainers.pl to spit out the expected results for any
> patches to clock drivers that are in sub-directories of drivers/clk,
> e.g. drivers/clk/tegra/.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

I was tempted to NAK since this will result in more mail for me, but
I've taken it in despite that obvious bug.

Thanks,
Mike

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdd0544..e8e4696 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2125,9 +2125,10 @@ M:       Mike Turquette <mturquette@linaro.org>
>  L:     linux-arm-kernel at lists.infradead.org (same as CLK API & CLKDEV)
>  T:     git git://git.linaro.org/people/mturquette/linux.git
>  S:     Maintained
> -F:     drivers/clk/clk.c
> -F:     drivers/clk/clk-*
> +F:     drivers/clk/
> +X:     drivers/clk/clkdev.c
>  F:     include/linux/clk-pr*
> +F:     include/linux/clk/
>  
>  COMMON INTERNET FILE SYSTEM (CIFS)
>  M:     Steve French <sfrench@samba.org>
> -- 
> 1.8.1.5
