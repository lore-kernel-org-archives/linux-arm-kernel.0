From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 May 2018 09:18:53 +0100
Subject: [PATCH 08/18] arm64: convert raw syscall invocation to C
In-Reply-To: <20180514180029.GA23250@light.dominikbrodowski.net>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-9-mark.rutland@arm.com>
 <20180514180029.GA23250@light.dominikbrodowski.net>
Message-ID: <20180515081839.aenqaruro5me42av@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 08:00:29PM +0200, Dominik Brodowski wrote:
> > +static void __invoke_syscall(struct pt_regs *regs, syscall_fn_t syscall_fn)
> > +{
> > +	regs->regs[0] = syscall_fn(regs->regs[0], regs->regs[1],
> > +				   regs->regs[2], regs->regs[3],
> > +				   regs->regs[4], regs->regs[5]);
> > +}
> 
> Any specific reason to have this in a separate function? This seems to be
> called only from one instance, namely

I wanted to keep the raw syscall invocation logically separate from the syscall
table lookup and ni_syscall fallback, so that it was easier to verify in isolation.

I don't think it's a big deal either way, though.

Thanks,
Mark.
