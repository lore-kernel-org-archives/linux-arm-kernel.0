From: mingo@kernel.org (Ingo Molnar)
Date: Sun, 6 May 2018 14:11:29 +0200
Subject: [PATCH] locking/atomics/powerpc: Move cmpxchg helpers to
 asm/cmpxchg.h and define the full set of cmpxchg APIs
In-Reply-To: <20180505140340.uzfhoc42xvas4m72@tardis>
References: <20180504180909.dnhfflibjwywnm4l@lakrids.cambridge.arm.com>
 <20180505081100.nsyrqrpzq2vd27bk@gmail.com>
 <20180505084721.GA32344@noisy.programming.kicks-ass.net>
 <20180505090403.p2ywuen42rnlwizq@gmail.com>
 <20180505093829.xfylnedwd5nonhae@gmail.com>
 <20180505101609.5wb56j4mspjkokmw@tardis>
 <20180505103550.s7xsnto7tgppkmle@gmail.com>
 <20180505112817.ihrb726i37bwm4cj@tardis>
 <20180505132751.gwzu2vbzibr2risd@gmail.com>
 <20180505140340.uzfhoc42xvas4m72@tardis>
Message-ID: <20180506121129.baacc4fxgr72rzex@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Boqun Feng <boqun.feng@gmail.com> wrote:

> > The only change I made beyond a trivial build fix is that I also added the release 
> > atomics variants explicitly:
> > 
> > +#define atomic_cmpxchg_release(v, o, n) \
> > +	cmpxchg_release(&((v)->counter), (o), (n))
> > +#define atomic64_cmpxchg_release(v, o, n) \
> > +	cmpxchg_release(&((v)->counter), (o), (n))
> > 
> > It has passed a PowerPC cross-build test here, but no runtime tests.
> > 
> 
> Do you have the commit at any branch in tip tree? I could pull it and
> cross-build and check the assembly code of lib/atomic64_test.c, that way
> I could verify whether we mess something up.
> 
> > Does this patch look good to you?
> > 
> 
> Yep!

Great - I have pushed the commits out into the locking tree, they can be found in:

  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core

The PowerPC preparatory commit from you is:

  0476a632cb3a: locking/atomics/powerpc: Move cmpxchg helpers to asm/cmpxchg.h and define the full set of cmpxchg APIs

Thanks,

	Ingo
