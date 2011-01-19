From: rabin@rab.in (Rabin Vincent)
Date: Wed, 19 Jan 2011 22:34:41 +0530
Subject: SMP: BUG() on cat /proc/$PID/stack
In-Reply-To: <20110113231136.GF24149@n2100.arm.linux.org.uk>
References: <AANLkTinSNPC7+m1Uie5hbUW_hgPecAK=RRGKkMx2AqOm@mail.gmail.com>
	<20110113231136.GF24149@n2100.arm.linux.org.uk>
Message-ID: <20110119165516.GA19356@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 11:11:36PM +0000, Russell King - ARM Linux wrote:
> x86 stack walking is very different from ARM unwinding.  I'd rather not
> expose the unwinder to a volatile stack - that's probably a recipe for
> it "sometimes" working and other times going oops because the stack
> changed beneath it.

Even on UP, with preemption enabled, isn't there no guarantee that the
target stack won't change beneath us, since the task we're examining can
preempt us?

Don't we need something like the below?

8<------
