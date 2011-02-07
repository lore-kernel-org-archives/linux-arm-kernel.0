From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 07 Feb 2011 14:54:19 +0100
Subject: [PATCH] sched: provide scheduler_ipi() callback in response to
	smp_send_reschedule()
In-Reply-To: <1297034792.14982.10.camel@pasglop>
References: <1295262433.30950.53.camel@laptop>
	<1297034792.14982.10.camel@pasglop>
Message-ID: <1297086859.13327.16.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-07 at 10:26 +1100, Benjamin Herrenschmidt wrote:
> You missed:
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9813605..467d122 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -98,6 +98,7 @@ void smp_message_recv(int msg)
>                 break;
>         case PPC_MSG_RESCHEDULE:
>                 /* we notice need_resched on exit */
> +               scheduler_ipi();
>                 break;
>         case PPC_MSG_CALL_FUNC_SINGLE:
>                 generic_smp_call_function_single_interrupt();
> 
> Fold that in and add:
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks Ben!
