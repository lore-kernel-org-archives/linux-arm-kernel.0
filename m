From: tixy@yxit.co.uk (Tixy)
Date: Fri, 15 Jun 2012 15:53:41 +0100
Subject: [PATCH] kprobes: only test 'sub pc, pc, #1b-2b+8-2' on ARMv6
In-Reply-To: <CAH+eYFCGdLdnbuOWB8=LWDXKCq-M4Bs5k2hyKEfZMmAZ-VVJCw@mail.gmail.com>
References: <1339502874-9104-1-git-send-email-rabin.vincent@stericsson.com>
 <1339571937.2759.13.camel@computer2.home>
 <CAH+eYFDhXCJRrgX+KTX0bPU89DyGfmb+bD8Cvm-3_iyCuk_==w@mail.gmail.com>
 <1339767385.2961.7.camel@computer2.home>
 <CAH+eYFCGdLdnbuOWB8=LWDXKCq-M4Bs5k2hyKEfZMmAZ-VVJCw@mail.gmail.com>
Message-ID: <1339772021.2794.12.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-06-15 at 19:30 +0530, Rabin Vincent wrote:
> On Fri, Jun 15, 2012 at 7:06 PM, Tixy <tixy@yxit.co.uk> wrote:
> >> How about the following check instead?  At least one other place uses
> >> it.
> >
> > Can't you point out the other place which uses it, I couldn't find it.
> 
> arch/arm/kernel/entry-armv.S:445
> #if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7

Yes, that's going to need looking at too when V8 arrives.

> > The proposed patch below would work, but feels slightly off as it
> > assumes that no one will build a kernel to support V6 and V8, but
> > without V7. That does seem highly unlikely though, so I personally
> > wouldn't object to the patch.
> 
> I've no preference either way, so if a deletion of the test case would get your
> acked-by instead of just a non-objection, I'll do that.

Actually, the kprobes implementation and test code will need looking at
again when V8 hits mainline, so lets not worry about it for the moment.
So, in that case, I agree with your revised patch which tests for not
CONFIG_CPU_V7 and you have:

Acked-by: Jon Medhurst <tixy@yxit.co.uk>

Thanks for looking at kprobes and contributing fixes.

As Russell King is the official maintainer of this code, can you add
your patches to his patch system?

Thanks again.

-- 
Tixy
