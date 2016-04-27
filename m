From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 27 Apr 2016 17:22:11 +0800
Subject: [PATCH v2] ARM: reboot: remove duplicated local_irq_disable()
In-Reply-To: <1459320308-4584-1-git-send-email-jszhang@marvell.com>
References: <1459320308-4584-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160427172211.395b846a@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

On Wed, 30 Mar 2016 14:45:08 +0800 Jisheng Zhang wrote:

> Once entering machine_halt() and machine_restart(), local_irq_disable()
> is called, and local irq is kept disabled, so the local_irq_disable()
> at the end of these two functions are not necessary, remove it.

Could I put the patch in your patch tracking system?

Thanks,
Jisheng

> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> 
> Since v1:
>  - correct typo in commit msg
> 
>  arch/arm/kernel/reboot.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
> index 71a2ff9..3fa867a 100644
> --- a/arch/arm/kernel/reboot.c
> +++ b/arch/arm/kernel/reboot.c
> @@ -104,8 +104,6 @@ void machine_halt(void)
>  {
>  	local_irq_disable();
>  	smp_send_stop();
> -
> -	local_irq_disable();
>  	while (1);
>  }
>  
> @@ -150,6 +148,5 @@ void machine_restart(char *cmd)
>  
>  	/* Whoops - the platform was unable to reboot. Tell the user! */
>  	printk("Reboot failed -- System halted\n");
> -	local_irq_disable();
>  	while (1);
>  }
