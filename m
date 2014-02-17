From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Feb 2014 18:34:28 +0000
Subject: Recent 3.x kernels: Memory leak causing OOMs
In-Reply-To: <20140216214354.GA12947@thunk.org>
References: <20140216200503.GN30257@n2100.arm.linux.org.uk>
 <20140216214354.GA12947@thunk.org>
Message-ID: <20140217183428.GA8687@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 04:43:54PM -0500, Theodore Ts'o wrote:
> On Sun, Feb 16, 2014 at 08:05:04PM +0000, Russell King - ARM Linux wrote:
> > I have another machine which OOM'd a week ago with plenty of unused swap
> > - it uses ext3 on raid1 and is a more busy system.  That took 41 days
> > to show, and upon reboot, it got a kernel with kmemleak enabled.  So far,
> > after 7 days, kmemleak has found nothing at all.
> 
> If kmemleak doesn't show anything, then presumably it's not a leak of
> the slab object.  Does /proc/meminfo show anything interesting?  Maybe
> it's a page getting leaked (which wouldn't be noticed by kmemleak)

Kmemleak also doesn't notice leaked objects that are added to a list for
example (still referenced). Maybe /proc/slabinfo would give some clues.

-- 
Catalin
