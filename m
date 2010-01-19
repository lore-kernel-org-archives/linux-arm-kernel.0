From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 09:02:35 +0000
Subject: Kernel Start-up Time
In-Reply-To: <201001191036.21594.caglarakyuz@gmail.com>
References: <201001181010.01975.caglarakyuz@gmail.com>
	<201001181054.59214.caglarakyuz@gmail.com>
	<1263829143.3207.34.camel@linux-1lbu>
	<201001191036.21594.caglarakyuz@gmail.com>
Message-ID: <20100119090235.GC24447@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 10:36:21AM +0200, Caglar Akyuz wrote:
> What I'm looking for is whether early arm boot sequence is 1.3 secs or not. I 
> may be wrong but my guess is before jumping to generic "start_kernel" function 
> following files are executed:
> 
> * arch/arm/kernel/head.S
> * arch/arm/kernel/head-common.S
> * arch/arm/mm/proc-arm926.S
> 
> And these 3 files cost me 1.3 seconds. Initializing page tables, caches etc 
> costing that much doesn't seem optimal to me. This is what I'm trying to find 
> out.

Only if your CPU is really inefficient when caches are turned off will
it take 1.3 seconds.

Try reading a cycle counter at the start of head.S, save it in memory.
Read it again in start_kernel() and save it somewhere again, and
compare the two values.  I think you'll find that it's not this code
which is taking 1.3 seconds.
