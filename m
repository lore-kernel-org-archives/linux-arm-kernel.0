From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Jun 2012 13:23:15 +0800
Subject: [PATCH 1/1] pinctrl: pinctrl-mxs: fix a compiling error
In-Reply-To: <1340167717-13082-1-git-send-email-b29396@freescale.com>
References: <1340167717-13082-1-git-send-email-b29396@freescale.com>
Message-ID: <20120620052312.GA1568@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 12:48:37PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The compiling error is:
> drivers/pinctrl/pinctrl-mxs.c: In function 'mxs_dt_node_to_map':
> drivers/pinctrl/pinctrl-mxs.c:140: error: implicit declaration of function 'free'
> drivers/pinctrl/pinctrl-mxs.c:140: warning: incompatible implicit declaration of built-in function 'free'
> It should be kfree.
> 

Already fixed by Fabio.

http://git.kernel.org/?p=linux/kernel/git/linusw/linux-pinctrl.git;a=commit;h=14e1e9f5cadb7cff3a2846c27cc1b9c8f207ee18

Regards,
Shawn

> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-mxs.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
> index afb50ee..4ba4636 100644
> --- a/drivers/pinctrl/pinctrl-mxs.c
> +++ b/drivers/pinctrl/pinctrl-mxs.c
> @@ -137,7 +137,7 @@ static int mxs_dt_node_to_map(struct pinctrl_dev *pctldev,
>  
>  free_group:
>  	if (!purecfg)
> -		free(group);
> +		kfree(group);
>  free:
>  	kfree(new_map);
>  	return ret;
> -- 
> 1.7.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
