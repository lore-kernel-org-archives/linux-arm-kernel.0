From: janboe.ye@gmail.com (ye janboe)
Date: Tue, 10 Aug 2010 11:27:54 +0800
Subject: [PATCH] arm: show_regs dump stack when ARM_UNWIND enable
In-Reply-To: <20100722080016.GF6802@n2100.arm.linux.org.uk>
References: <20100720152431.GA17092@localhost.localdomain>
	<1279640276.10002.35.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimbxrdFeA513Y59OX6y9lwfh3OBjqerazKcwIXx@mail.gmail.com>
	<1279704065.17464.1.camel@e102109-lin.cambridge.arm.com>
	<20100721172428.GA5881@localhost.localdomain>
	<20100722080016.GF6802@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimjAp8-WQ2D_-gJkh_wBW0yuDfGs6DaMgwk59e=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Russell

I agree with this.

But I am confused with c_bactrace in arm_syscall. This function is
used to dump stack when arm syscall failed.
regs->ARM_fp should be an userspace address and c_backtrace should
fail to dump the backtrace.

Do you know what the purpose c_backtrace here?

Thanks

Janboe


2010/7/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Jul 22, 2010 at 01:24:28AM +0800, Janboe Ye wrote:
>> Is there any way for arm unwind to do user space backtrace like
>> c_backtrace in arm_syscall?
>
> That's a job for userspace, which would have access to the program
> debug information, which is necessary for unwinding EABI programs.
> The debug information is not loaded into the programs address space
> when you run it, and therefore would not be available to the kernel.
>
