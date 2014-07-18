From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 18 Jul 2014 16:27:50 -0400
Subject: [PATCH 4/4] (RFC) X86: add IPI tracepoints
In-Reply-To: <1405660735-13408-5-git-send-email-nicolas.pitre@linaro.org>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-5-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20140718162750.62cbf965@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Jul 2014 01:18:55 -0400
Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

 
> diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
> index be8e1bde07..e154d176cf 100644
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -31,6 +31,12 @@
>  #include <asm/apic.h>
>  #include <asm/nmi.h>
>  #include <asm/trace/irq_vectors.h>
> +
> +#define CREATE_TRACE_POINTS
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE

I'm curious to why you added the #undefs. I wouldn't think they were
needed.

-- Steve

> +#include <trace/events/ipi.h>
> +
>  /*
>   *	Some notes on x86 processor bugs affecting SMP operation:
>   *
