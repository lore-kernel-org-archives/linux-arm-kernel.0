From: mgherzan@gmail.com (Mircea Gherzan)
Date: Wed, 21 Dec 2011 16:43:47 +0200
Subject: [PATCH] ARM: net: JIT compiler for packet filters
In-Reply-To: <alpine.LFD.2.02.1112191231520.2907@xanadu.home>
References: <1324252185-15894-1-git-send-email-mgherzan@gmail.com>
 <alpine.LFD.2.02.1112191231520.2907@xanadu.home>
Message-ID: <20111221144346.GB3229@swarm.cs.pub.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:42:49PM -0500, Nicolas Pitre wrote:
> On Mon, 19 Dec 2011, Mircea Gherzan wrote:
> 
> > +static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
> > +{
> > +	if (ctx->target != NULL)
> > +		ctx->target[ctx->idx] = inst | (cond << 28);
> > +
> > +	ctx->idx++;
> > +}
> 
> You might consider the patch titled "ARM: Add generic instruction opcode 
> manipulation helpers" that Dave Martin just posted and rely on it to 
> make your code compatible with BE8 mode as well.

That patch is not in devel-stable and I don't want to introduce further
dependencies for the time being. Once both patches are in mainline, I
will take a look.

> Also it seems that you are making the distinction between pre-ARMv7 and 
> ARMv7+ while in most cases it should be pre-ARMv6 and ARMv6+

Has been fixed in v2 of the patch.

Mircea
