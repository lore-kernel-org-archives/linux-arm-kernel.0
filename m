From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 28 May 2010 10:03:57 +0530
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <000601cafdbd$24b7c4f0$6e274ed0$@deacon@arm.com>
References: <1274973118-11874-1-git-send-email-will.deacon@arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C57A6E03@dbde02.ent.ti.com>
	<000601cafdbd$24b7c4f0$6e274ed0$@deacon@arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C57A6F23@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Thursday, May 27, 2010 10:24 PM
> To: Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org
> Cc: Russell King - ARM Linux
> Subject: RE: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
> 
> Hi Santosh,
> 
> > > This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
> > > forcing a flushing of the write buffer on SMP systems before the next load
> > > takes place. If the Kernel is not compiled for SMP support, this will expand
> > > to a barrier() as before.
> > >
> > I have missed this thread. Is this not applicable for ARMv7 MP Cores as well??
> 
> You can pick up on some of the old thread here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/012874.html
> 
> Actually, the ChangeLog I wrote for that patch is better, so I'll update
> my current one.
> 
> To answer your question; this problem only occurs on ARM11MPCore. For ARMv7MP,
> stores are guaranteed to become visible eventually [i.e. they can't be held up
> indefinitely by a sequence of aggresive loads].
> 
> An addition to the ARM ARM [Section A3.8.2] says:
> 
> * For an implementation that does not include the Multiprocessing Extensions,
> it is IMPLEMENTATION DEFINED whether all writes become globally observed in
> their shareability domain in a finite period of time, or whether in some cases,
> software must execute a DSB to ensure the visibility of some writes.
> 
> * For an implementation that includes the Multiprocessing Extensions, all writes
> become globally observed in their shareability domain in a finite period of time.
> 
Thanks. It's clear to me now.

Regards,
Santosh
