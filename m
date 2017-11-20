From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 20 Nov 2017 12:52:04 -0800
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <20171120192806.xrbewr6mcffu3i3x@hirez.programming.kicks-ass.net>
References: <CAKwvOd=k=iVQvWmzP1E3XHUCYLoJgx+F9zoPuE+R2oaw_ePUVA@mail.gmail.com>
 <20171116173417.nqsh5dpu65uj7b5s@hirez.programming.kicks-ass.net>
 <20171116174830.GX3624@linux.vnet.ibm.com>
 <CAKwvOdkDz1yRo=Skt_mWxs0uucK+adXx8kFQksMbTE3ofnpUMQ@mail.gmail.com>
 <20171116183950.GA3624@linux.vnet.ibm.com>
 <20171116184508.GC21898@arm.com>
 <20171116191307.GC3624@linux.vnet.ibm.com>
 <20171116201701.GA143965@samitolvanen.mtv.corp.google.com>
 <20171120180554.GM32488@arm.com>
 <20171120192806.xrbewr6mcffu3i3x@hirez.programming.kicks-ass.net>
Message-ID: <20171120205204.GY3624@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 20, 2017 at 08:28:06PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 20, 2017 at 06:05:55PM +0000, Will Deacon wrote:
> > This is a thorny issue, but RCU (specifically rcu_dereference but probably
> > also some READ_ONCEs) relies on being able to utilise syntactic dependency
> > chains to order local accesses to shared variables.
> 
> Well, we used to have READ_ONCE() and smp_read_barrier_depends(), but
> we recently munged them together, in the process getting rid of
> lockless_dereference().
> 
> So for sure, READ_ONCE() must be able to do the address dependency
> thing, otherwise tons of code comes apart.

I do hope that they track the volatile accesses produced by READ_ONCE().
Otherwise, it would not be good to apply this to anything touching MMIO.

							Thanx, Paul
