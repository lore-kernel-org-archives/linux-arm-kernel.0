From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Wed, 13 Dec 2017 10:54:56 -0500
Subject: [PATCH] IPI performance benchmark
In-Reply-To: <20171213104747.m4b5pbnlcroodfe7@yury-thinkpad>
References: <20171211141600.24401-1-ynorov@caviumnetworks.com>
 <20171211153332.GG15649@char.us.oracle.com>
 <20171213104747.m4b5pbnlcroodfe7@yury-thinkpad>
Message-ID: <20171213155456.GL10097@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 01:47:47PM +0300, Yury Norov wrote:
> On Mon, Dec 11, 2017 at 10:33:32AM -0500, Konrad Rzeszutek Wilk wrote:
> > On Mon, Dec 11, 2017 at 05:16:00PM +0300, Yury Norov wrote:
> > > This benchmark sends many IPIs in different modes and measures
> > > time for IPI delivery (first column), and total time, ie including
> > > time to acknowledge the receive by sender (second column).
> > > 
> > > The scenarios are:
> > > Dry-run:	do everything except actually sending IPI. Useful
> > > 		to estimate system overhead.
> > > Self-IPI:	Send IPI to self CPU.
> > > Normal IPI:	Send IPI to some other CPU.
> > > Broadcast IPI:	Send broadcast IPI to all online CPUs.
> > > 
> > > For virtualized guests, sending and reveiving IPIs causes guest exit.
> > > I used this test to measure performance impact on KVM subsystem of
> > > Christoffer Dall's series "Optimize KVM/ARM for VHE systems".
> > > 
> > > https://www.spinics.net/lists/kvm/msg156755.html
> > > 
> > > Test machine is ThunderX2, 112 online CPUs. Below the results normalized
> > > to host dry-run time. Smaller - better.
> > 
> > Would it make sense to also add spinlock contention tests? Meaning make
> > this framework a bit more generic so you could do IPI and you could
> > also do spinlock contention?
> > 
> > Like:
> > http://xenbits.xen.org/gitweb/?p=xentesttools/bootstrap.git;a=blob;f=root_image/drivers/spinlock_hog/spinlock_hog.c;h=040a154808452576b1aa5720a6282981319a5360;hb=HEAD
> 
> There's kernel/locking/locktorture.c for spinlock testing. Maybe it
> worth to add new testcase there? If you find my 'framework' more
> suitable for you, I'm also OK with it. Is my understanding correct
> that you want something like broadcast IPI case, but with different
> payload?

Yes, exactly!

But as I said, you have probably other things on your mind so this
is more of - 'it would be cool if you could do it, but if you don't
get to it - I understand' type.
