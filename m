From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 22 Jan 2013 08:38:25 -0800
Subject: [PATCH] clk: Deduplicate exit code in clk_set_rate
In-Reply-To: <1358525259-7979-1-git-send-email-novroy@riseup.net>
References: <1358525259-7979-1-git-send-email-novroy@riseup.net>
Message-ID: <20130122163825.24671.24785@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nestor Ovroy (2013-01-18 08:07:39)
> On non-out case 'return ret;' is equivalent to 'return 0;' as the ret
> variable is initialized at 0 and never changed.
> 
> Signed-off-by: Nestor Ovroy <novroy@riseup.net>

Nestor,

Thanks for the fix.  Taken into clk-next.

Regards,
Mike

> ---
>  drivers/clk/clk.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 251e45d..0e21d7a 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -948,13 +948,10 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>         }
>  
>         /* change the rates */
>         clk_change_rate(top);
>  
> -       mutex_unlock(&prepare_lock);
> -
> -       return 0;
>  out:
>         mutex_unlock(&prepare_lock);
>  
>         return ret;
>  }
> -- 
> 1.7.10.4
