From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 26 Oct 2015 08:50:59 +0100
Subject: [PATCH] ARM: v7-M: Use ret_to_user_from_irq in PendSV handler
In-Reply-To: <1445818252-13175-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1445818252-13175-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <20151026075059.GV4931@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 09:10:52PM -0300, Ezequiel Garcia wrote:
> The PendSV handler calls v7m_exception_entry which
> disables IRQs. Therefore, since IRQs are already disabled,
> the PendSV handler can return using ret_to_user_from_irq.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Looks right. How did you notice this?

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

> ---
> Tested on a NXP LPC43xx platform.
> 
>  arch/arm/kernel/entry-v7m.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
> index b6c8bb9315e7..907534f97053 100644
> --- a/arch/arm/kernel/entry-v7m.S
> +++ b/arch/arm/kernel/entry-v7m.S
> @@ -88,7 +88,7 @@ __pendsv_entry:
>  	@ execute the pending work, including reschedule
>  	get_thread_info tsk
>  	mov	why, #0
> -	b	ret_to_user
> +	b	ret_to_user_from_irq
>  ENDPROC(__pendsv_entry)
>  
>  /*
> -- 
> 2.5.2
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
