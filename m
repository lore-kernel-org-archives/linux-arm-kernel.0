From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 12:42:49 -0500 (EST)
Subject: [PATCH] ARM: net: JIT compiler for packet filters
In-Reply-To: <1324252185-15894-1-git-send-email-mgherzan@gmail.com>
References: <1324252185-15894-1-git-send-email-mgherzan@gmail.com>
Message-ID: <alpine.LFD.2.02.1112191231520.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2011, Mircea Gherzan wrote:

> +static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
> +{
> +	if (ctx->target != NULL)
> +		ctx->target[ctx->idx] = inst | (cond << 28);
> +
> +	ctx->idx++;
> +}

You might consider the patch titled "ARM: Add generic instruction opcode 
manipulation helpers" that Dave Martin just posted and rely on it to 
make your code compatible with BE8 mode as well.

Also it seems that you are making the distinction between pre-ARMv7 and 
ARMv7+ while in most cases it should be pre-ARMv6 and ARMv6+


Nicolas
