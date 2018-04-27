From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Apr 2018 17:18:10 +0100
Subject: [PATCH] arm: port KCOV to arm
In-Reply-To: <CACT4Y+b_cAKf80y5a8KaV7P=-KtcB83E7x-SXv-Uq_kxzy_7wA@mail.gmail.com>
References: <20180426130846.130976-1-dvyukov@google.com>
 <20180426134057.4sahhqrbkltwmfsk@lakrids.cambridge.arm.com>
 <CACT4Y+Z35mOAybskjxVhxvW+GrbOZ4c9s2LT+Ca_fE9ZufoiGQ@mail.gmail.com>
 <20180426142948.n74p52esmbvsqrow@lakrids.cambridge.arm.com>
 <CACT4Y+b+kHWstEWDDOh6unGSHnetnyJ-Gut1E494XGM1rFozBQ@mail.gmail.com>
 <CACT4Y+ZfQyCd+dBNJEUvVquM8EN51JoOrrENJ+Q7Hpb0wF5xrA@mail.gmail.com>
 <20180427130643.klvm4rqxhv7w5f2o@lakrids.cambridge.arm.com>
 <CACT4Y+b_cAKf80y5a8KaV7P=-KtcB83E7x-SXv-Uq_kxzy_7wA@mail.gmail.com>
Message-ID: <20180427161810.kuncq7rtcpyl7pql@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2018 at 03:51:22PM +0200, Dmitry Vyukov wrote:
> On Fri, Apr 27, 2018 at 3:06 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Can you share your kernel config?
> 
> Attached. It's pretty much vexpress_defconfig with few minor
> additions. Here is full description of what I am doing:
> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_arm-kernel.md

Cheers!

> FWIW when I do "KCOV_INSTRUMENT_fault.o := n" everything works and I
> see reasonable coverage.

While this may be the case, I think it's papering over a bug rather than
solving it.

[...]

> > I can't reproduce the issue on real hardware atop of v4.17-rc2, when
> > booting and running a standard ARMv7 buildroot userspace. So the kcov
> > mode check seems fine to me.
> 
> It happens after brief fuzzing with syzkaller. So it's both kcov
> opened and some weird syscall workload. Again, here is everything what
> I am doing:
> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_arm-kernel.md

I've set this up, and while I see RCU stalls and "no output from test
machine" warnings, I'm not seeing any reports with KCOV splats.

Are you somehow connecting to a VM which failed with no output?

Thanks,
Mark.
