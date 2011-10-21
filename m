From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 22 Oct 2011 00:33:28 +0200
Subject: [RESEND PATCH] PM / Clocks: Remove redundant NULL checks before
	kfree()
In-Reply-To: <1319068532-21287-1-git-send-email-jhbird.choi@samsung.com>
References: <1319068532-21287-1-git-send-email-jhbird.choi@samsung.com>
Message-ID: <201110220033.29015.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 20, 2011, jhbird.choi at samsung.com wrote:
> From: Jonghwan Choi <jhbird.choi@samsung.com>
> 
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>

Applied to linux-pm/linux-next, but I didn't have to resend it.

Thanks,
Rafael


> ---
>  drivers/base/power/clock_ops.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index b97294e..3ecc303 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -114,9 +114,7 @@ static void __pm_clk_remove(struct pm_clock_entry *ce)
>  			clk_put(ce->clk);
>  	}
>  
> -	if (ce->con_id)
> -		kfree(ce->con_id);
> -
> +	kfree(ce->con_id);
>  	kfree(ce);
>  }
>  
> 
