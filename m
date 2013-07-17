From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 10:15:19 +0100
Subject: sched_clock always 0 and no process time accounting with 3.11-rc1
In-Reply-To: <20130717091209.GL6950@tarshish>
References: <CAMo8BfLO31GgMMA_hENr0xm=qaUz3EVLtaQ8hewiQHdbV+s6sA@mail.gmail.com>
 <20130717061925.GC6950@tarshish>
 <20130717090354.GK24642@n2100.arm.linux.org.uk>
 <20130717091209.GL6950@tarshish>
Message-ID: <20130717091519.GL24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 12:12:09PM +0300, Baruch Siach wrote:
> Hi Russell,
> 
> On Wed, Jul 17, 2013 at 10:03:55AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jul 17, 2013 at 09:19:25AM +0300, Baruch Siach wrote:
> > > Apparently the expression '(1 << 32)' evaluates to 1 on xtensa cross gcc, and 
> > > x86_84 native gcc. According to my limited understanding, the C compiler is 
> > > allowed to do so. This caused sched_clock_32() to return constant 0. I wonder 
> > > how it didn't bite the ARM people who are using this code from quite some time 
> > > (added LAKL to CC).
> > 
> > It (a) used to be only 32-bit, and (b) <<32 on ARM evaluates to zero in
> > a 32-bit context (it's not a rotate).
> > 
> > Patch looks fine.
> 
> Thanks for the confirmation, I'll take it as an ack if you don't mind.

If you want it as an ack, use rmk+kernel at arm.linux.org.uk as the email
address please.
