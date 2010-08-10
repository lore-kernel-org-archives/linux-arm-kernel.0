From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 23:59:19 +0100
Subject: [PATCH] arm: show_regs dump stack when ARM_UNWIND enable
In-Reply-To: <AANLkTimjAp8-WQ2D_-gJkh_wBW0yuDfGs6DaMgwk59e=@mail.gmail.com>
References: <20100720152431.GA17092@localhost.localdomain>
	<1279640276.10002.35.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimbxrdFeA513Y59OX6y9lwfh3OBjqerazKcwIXx@mail.gmail.com>
	<1279704065.17464.1.camel@e102109-lin.cambridge.arm.com>
	<20100721172428.GA5881@localhost.localdomain>
	<20100722080016.GF6802@n2100.arm.linux.org.uk>
	<AANLkTimjAp8-WQ2D_-gJkh_wBW0yuDfGs6DaMgwk59e=@mail.gmail.com>
Message-ID: <20100810225919.GG7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 11:27:54AM +0800, ye janboe wrote:
> hi, Russell
> 
> I agree with this.
> 
> But I am confused with c_bactrace in arm_syscall. This function is
> used to dump stack when arm syscall failed.
> regs->ARM_fp should be an userspace address and c_backtrace should
> fail to dump the backtrace.
> 
> Do you know what the purpose c_backtrace here?

Debugging kernel failures in earlier kernels when there wasn't such
stuff as EABI to worry about - from times when programs were built
with frame pointers.

That call should probably be removed now.
