From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 20 May 2015 11:42:39 +0200
Subject: [PATCH] [media] coda: remove extraneous TRACE_SYSTEM_STRING
In-Reply-To: <4790110.OLqddgPxAn@wuerfel>
References: <4790110.OLqddgPxAn@wuerfel>
Message-ID: <1432114959.4466.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 19.05.2015, 23:34 +0200 schrieb Arnd Bergmann:
> The coda tracing code causes lots of warnings like
> 
> In file included from /git/arm-soc/include/trace/define_trace.h:90:0,
>                  from /git/arm-soc/drivers/media/platform/coda/trace.h:203,
>                  from /git/arm-soc/drivers/media/platform/coda/coda-bit.c:34:
> /git/arm-soc/include/trace/ftrace.h:28:0: warning: "TRACE_SYSTEM_STRING" redefined
>  #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
>  ^
> In file included from /git/arm-soc/include/trace/define_trace.h:83:0,
>                  from /git/arm-soc/drivers/media/platform/coda/trace.h:203,
>                  from /git/arm-soc/drivers/media/platform/coda/coda-bit.c:34:
> /git/arm-soc/drivers/media/platform/coda/./trace.h:12:0: note: this is the location of the previous definition
>  #define TRACE_SYSTEM_STRING __stringify(TRACE_SYSTEM)
> 
> From what I can tell, this is just the result of a bogus TRACE_SYSTEM_STRING
> definition, and removing that one makes the warnings go away.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9a1a8f9953f ("[media] coda: Add tracing support")
> 
> diff --git a/drivers/media/platform/coda/trace.h b/drivers/media/platform/coda/trace.h
> index d1d06cbd1f6a..781bf7286d53 100644
> --- a/drivers/media/platform/coda/trace.h
> +++ b/drivers/media/platform/coda/trace.h
> @@ -9,8 +9,6 @@
>  
>  #include "coda.h"
>  
> -#define TRACE_SYSTEM_STRING __stringify(TRACE_SYSTEM)
> -
>  TRACE_EVENT(coda_bit_run,
>  	TP_PROTO(struct coda_ctx *ctx, int cmd),

Steven sent the same fix to linux-next recently ("[PATCH][linux-next]
coda: Do not define TRACE_SYSTEM_STRING"). As he points out, this is the
result of a bogus copy & paste. Kamil, would you queue either of them
with my
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

thanks
Philipp
