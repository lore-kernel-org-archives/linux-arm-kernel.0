From: dan@debian.org (Daniel Jacobowitz)
Date: Wed, 16 Sep 2009 10:40:51 -0400
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <200909160926.02036.schindele@nentec.de>
References: <200909160926.02036.schindele@nentec.de>
Message-ID: <20090916144051.GA19307@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 09:26:01AM +0200, Juergen Schindele wrote:
> Hello all,
> we tried to implement a thread based software on our PXA270 based platform but
> we had trouble with pthreads. So i modyfied a tiny progam to test. This little progam creates
> 10 threads and each thread does print something (an index an a pointer to itself). 
> 
> On my PC with Suse 11.0 Linux (kernel 2.6.27) this works fine as supposed to.
> Each thread has his turn and print his own values.
> 
> But on our pxa270 platform the thread switch does not (or really rarely) happen
> and only one thread is printing always the same values. So i suppose thread
> switching is not working!
> 
> Any hints or experiences are welcome !!!

It's just a wild guess, but check your sched_clock implementation.  I
fixed a similar problem in QEMU last week; the kernel used to function
OK with sched_clock always returning zero, but some time between
2.6.25 and 2.6.28 became dependent on it.

-- 
Daniel Jacobowitz
CodeSourcery
