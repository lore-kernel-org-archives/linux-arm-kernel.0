From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 6 Apr 2011 13:37:19 -0400 (EDT)
Subject: [RFC PATCH] ARM: fiq: Refactor {get,set}_fiq_regs() for
 Thumb-2
In-Reply-To: <1302085787-15069-1-git-send-email-dave.martin@linaro.org>
References: <1302085787-15069-1-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1104061329520.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Apr 2011, Dave Martin wrote:

>  * To remove the risk of inconvenient register allocation decisions
>    by the compiler, these functions are separated out as pure
>    assembler.
> 
>  * The apcs frame manipulation code is not applicable for Thumb-2
>    (and also not easily compatible).  Since it's not essential to
>    have a full frame on these leaf assembler functions, the frame
>    manipulation is removed, in the interests of simplicity.
> 
>  * Split up ldm/stm instructions to be compatible with Thumb-2,
>    as well as avoiding instruction forms deprecated on >= ARMv7.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

I like.  Minor nit:

> +/*
> + * Taking an interrupt in FIQ mode is death, so both these functions
> + * disable irqs for the duration.  Note - these functions are almost
> + * entirely coded in assembly.
> + */

I think it is obvious the last sentence may go, especially since 
"almost" is not exactly true anymore.

Other than that:

Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>


Nicolas
