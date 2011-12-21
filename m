From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 21 Dec 2011 10:07:17 -0500 (EST)
Subject: [PATCH] ARM: net: JIT compiler for packet filters
In-Reply-To: <20111221144346.GB3229@swarm.cs.pub.ro>
References: <1324252185-15894-1-git-send-email-mgherzan@gmail.com>
 <alpine.LFD.2.02.1112191231520.2907@xanadu.home>
 <20111221144346.GB3229@swarm.cs.pub.ro>
Message-ID: <alpine.LFD.2.02.1112211006430.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Dec 2011, Mircea Gherzan wrote:

> On Mon, Dec 19, 2011 at 12:42:49PM -0500, Nicolas Pitre wrote:
> > On Mon, 19 Dec 2011, Mircea Gherzan wrote:
> > 
> > > +static inline void _emit(int cond, u32 inst, struct jit_ctx *ctx)
> > > +{
> > > +	if (ctx->target != NULL)
> > > +		ctx->target[ctx->idx] = inst | (cond << 28);
> > > +
> > > +	ctx->idx++;
> > > +}
> > 
> > You might consider the patch titled "ARM: Add generic instruction opcode 
> > manipulation helpers" that Dave Martin just posted and rely on it to 
> > make your code compatible with BE8 mode as well.
> 
> That patch is not in devel-stable and I don't want to introduce further
> dependencies for the time being. Once both patches are in mainline, I
> will take a look.

Fair enough.


Nicolas
