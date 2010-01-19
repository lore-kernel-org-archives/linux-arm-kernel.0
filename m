From: caglarakyuz@gmail.com (Caglar Akyuz)
Date: Tue, 19 Jan 2010 16:31:49 +0200
Subject: Kernel Start-up Time
In-Reply-To: <20100119090235.GC24447@n2100.arm.linux.org.uk>
References: <201001181010.01975.caglarakyuz@gmail.com>
	<201001191036.21594.caglarakyuz@gmail.com>
	<20100119090235.GC24447@n2100.arm.linux.org.uk>
Message-ID: <201001191631.49874.caglarakyuz@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 January 2010 11:02:35 am Russell King - ARM Linux wrote:
> On Tue, Jan 19, 2010 at 10:36:21AM +0200, Caglar Akyuz wrote:
> > What I'm looking for is whether early arm boot sequence is 1.3 secs or
> > not. I may be wrong but my guess is before jumping to generic
> > "start_kernel" function following files are executed:
> >
> > * arch/arm/kernel/head.S
> > * arch/arm/kernel/head-common.S
> > * arch/arm/mm/proc-arm926.S
> >
> > And these 3 files cost me 1.3 seconds. Initializing page tables, caches
> > etc costing that much doesn't seem optimal to me. This is what I'm trying
> > to find out.
> 
> Only if your CPU is really inefficient when caches are turned off will
> it take 1.3 seconds.
> 
> Try reading a cycle counter at the start of head.S, save it in memory.
> Read it again in start_kernel() and save it somewhere again, and
> compare the two values.  I think you'll find that it's not this code
> which is taking 1.3 seconds.
> 

Thanks, you were right. This part is only taking 3 milliseconds. It turns out 
that my usage of early printk was wrong.

Caglar
