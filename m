From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 10:03:55 +0100
Subject: sched_clock always 0 and no process time accounting with 3.11-rc1
In-Reply-To: <20130717061925.GC6950@tarshish>
References: <CAMo8BfLO31GgMMA_hENr0xm=qaUz3EVLtaQ8hewiQHdbV+s6sA@mail.gmail.com>
 <20130717061925.GC6950@tarshish>
Message-ID: <20130717090354.GK24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 09:19:25AM +0300, Baruch Siach wrote:
> Apparently the expression '(1 << 32)' evaluates to 1 on xtensa cross gcc, and 
> x86_84 native gcc. According to my limited understanding, the C compiler is 
> allowed to do so. This caused sched_clock_32() to return constant 0. I wonder 
> how it didn't bite the ARM people who are using this code from quite some time 
> (added LAKL to CC).

It (a) used to be only 32-bit, and (b) <<32 on ARM evaluates to zero in
a 32-bit context (it's not a rotate).

Patch looks fine.  I wonder who takes it... after all, I used to look
after that code (after all, I'm the author of it), but now I guess as
it's been moved under kernel/time, it's someone elses responsibility.
