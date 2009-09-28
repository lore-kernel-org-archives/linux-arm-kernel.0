From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 16:16:24 +0300
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928124922.GA19778@shareable.org>
References: <20090928092919.GA30271@localhost>
	<20090928124922.GA19778@shareable.org>
Message-ID: <20090928131624.GK30271@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 02:49:22PM +0200, ext Jamie Lokier wrote:
> Imre Deak wrote:
> > Hi,
> > 
> > the following test app will cause an unhandled kernel paging request
> > on VIPT platforms. The triggering condition is the mmap_sem held by
> > thread_func while the main thread performs cache flushing.
> > 
> > Since the likelihood of this to trigger is relatively low, a patch will
> > follow that makes similar bugs more visible.
> 
> I would expect the likelihood of triggering would be higher for at
> least one of Java, Mono, Parrot or any of the modern Javascript
> engines.

True, the above statement is only valid for certain use patterns. I was
mainly interested in applications that do user range cache flushing as
part of their DMA requests and they didn't have threads with frequent
syscalls that required mmap_sem, so the problem remained hidden for a
long time.

--Imre
