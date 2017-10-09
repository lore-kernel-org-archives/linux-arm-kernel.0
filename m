From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Oct 2017 14:13:14 +0100
Subject: [PATCH v2 0/5] Switch arm64 over to qrwlock
In-Reply-To: <20171009124921.wtbzvqagges44brq@yury-thinkpad>
References: <1507296882-18721-1-git-send-email-will.deacon@arm.com>
 <20171008213052.ojyxpr56d2ypscjy@yury-thinkpad>
 <20171009095935.GC5127@arm.com>
 <20171009124921.wtbzvqagges44brq@yury-thinkpad>
Message-ID: <20171009131314.GA28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 03:49:21PM +0300, Yury Norov wrote:
> On Mon, Oct 09, 2017 at 10:59:36AM +0100, Will Deacon wrote:
> > On Mon, Oct 09, 2017 at 12:30:52AM +0300, Yury Norov wrote:
> > > There were 2 preparing patches in the series: 
> > > [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock
> > > and
> > > [PATCH 2/3] asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h
> > > 
> > > 1st patch is not needed anymore because Babu Moger submitted similar patch that
> > > is already in mainline: 9ab6055f95903 ("kernel/locking: Fix compile error with
> > > qrwlock.c"). Could you revisit second patch?
> > 
> > Sorry, not sure what you're asking me to do here.
> 
> It removes unneeded #include <linux/atomic.h> in
> include/asm-generic/qspinlock_types.h. Could you or someone else take
> it upstream?

My patch implements qrwlocks, not qspinlocks, so it's a bit weird to take
this random patch in the same series. Given that Arnd acked it, I'd suggest
either sending it through him, or leaving it until I get round to looking at
qspinlock for arm64 (see my reply to Peter).

Will
