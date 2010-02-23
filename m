From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 23 Feb 2010 08:47:05 -0500
Subject: [PATCH 04/10] ARM: ftrace: allow building without frame pointers
In-Reply-To: <1266090518-31120-5-git-send-email-rabin@rab.in>
References: <1266090518-31120-1-git-send-email-rabin@rab.in>
	<1266090518-31120-5-git-send-email-rabin@rab.in>
Message-ID: <1266932825.19540.17.camel@frodo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-02-14 at 01:18 +0530, Rabin Vincent wrote:
> With a new enough GCC, ARM function tracing can be supported without the
> need for frame pointers.  This is essential for Thumb-2 support, since
> frame pointers aren't available then.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>


>  
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 6c22d8a..7468ffe 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -126,7 +126,7 @@ if FTRACE
>  config FUNCTION_TRACER
>  	bool "Kernel Function Tracer"
>  	depends on HAVE_FUNCTION_TRACER
> -	select FRAME_POINTER
> +	select FRAME_POINTER if (!ARM_UNWIND)
>  	select KALLSYMS
>  	select GENERIC_TRACER
>  	select CONTEXT_SWITCH_TRACER

Ah, evolution is keeping these patches out of order, so I did not see
this change before commenting about the change to the Makefile.

A better comment is needed in the Makefile.

-- Steve
