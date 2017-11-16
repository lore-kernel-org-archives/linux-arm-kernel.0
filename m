From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 16 Nov 2017 11:13:07 -0800
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <20171116184508.GC21898@arm.com>
References: <20171116161731.GA94341@samitolvanen.mtv.corp.google.com>
 <20171116163054.kcsdsomr7u2mqql2@hirez.programming.kicks-ass.net>
 <CAKwvOdkV_g0XAbGM+nF2zt=2+tHLLcj=pbSxRDd2HMbrtU3cZg@mail.gmail.com>
 <20171116165922.llrojrvomuihabrt@hirez.programming.kicks-ass.net>
 <CAKwvOd=k=iVQvWmzP1E3XHUCYLoJgx+F9zoPuE+R2oaw_ePUVA@mail.gmail.com>
 <20171116173417.nqsh5dpu65uj7b5s@hirez.programming.kicks-ass.net>
 <20171116174830.GX3624@linux.vnet.ibm.com>
 <CAKwvOdkDz1yRo=Skt_mWxs0uucK+adXx8kFQksMbTE3ofnpUMQ@mail.gmail.com>
 <20171116183950.GA3624@linux.vnet.ibm.com>
 <20171116184508.GC21898@arm.com>
Message-ID: <20171116191307.GC3624@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 06:45:08PM +0000, Will Deacon wrote:
> On Thu, Nov 16, 2017 at 10:39:51AM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 16, 2017 at 10:16:22AM -0800, Nick Desaulniers wrote:
> > > > On Thu, Nov 16, 2017 at 06:34:17PM +0100, Peter Zijlstra wrote:
> > > >> So the problem is that its very very hard (and painful) to find these
> > > >> bugs. Getting the tools people to comment on these specific
> > > >> optimizations would really help lots.
> > > 
> > > No doubt; I do not disagree with you.  Kernel developers have very
> > > important use cases for the language.
> > > 
> > > But the core point I'm trying to make is "do we need to block this
> > > patch set until issues with the C standards body in regards to the
> > > kernels memory model are resolved?"  I would hope the two are
> > > orthogonal and that we'd take them and then test them even more
> > > extensively than the developer has in order to find out.
> > 
> > Given that I have been working on getting the C and C++ standards to
> > correctly handle rcu_dereference() for more than ten years, I recommend
> > -against- waiting on standardization in the strongest possible terms.
> > And if you think that ten years is bad, the Java standards community has
> > been struggling with out-of-thin-air (OOTA) values for almost 20 years.
> > And the C and C++ standards haven't solved OOTA, either.
> 
> The problem is, if we go ahead with this change, the compiler *will* break
> some address dependencies and something will eventually go wrong. At that
> point, what do we do? Turn off some random compiler optimisation? Add a
> random barrier()?
> 
> We don't necessarily need standardisation, but we at least need guarantees
> from the compiler implementation that LTO/PGO will respect source level
> address dependencies. I don't think we have that today.

Ah, if "this patch set" meant "adding LTO", I stand corrected and I
apologize for my confusion.

I agree that we need LTO/PGO to be housebroken from an LKMM viewpoint
before it is enabled.

							Thanx, Paul
