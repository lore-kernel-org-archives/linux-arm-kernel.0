From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 13 May 2015 17:13:45 +0200 (CEST)
Subject: Build failures in -next due to use of __hrtimer_start_range_ns
 arm-ccn.c
In-Reply-To: <1431529683.3285.101.camel@arm.com>
References: <E1YsUw4-0002i4-Do@optimist> <20150513145101.GU2761@sirena.org.uk>
 <1431529683.3285.101.camel@arm.com>
Message-ID: <alpine.DEB.2.11.1505131712320.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 May 2015, Pawel Moll wrote:
> On Wed, 2015-05-13 at 15:51 +0100, Mark Brown wrote:
> > On Wed, May 13, 2015 at 12:34:48PM +0100, Build bot for Mark Brown wrote:
> > 
> > > 	arm64-allmodconfig
> > > ../drivers/bus/arm-ccn.c:924:3: error: implicit declaration of function '__hrtimer_start_range_ns' [-Werror=implicit-function-declaration]
> > > 
> > > 	arm-allmodconfig
> > > ../drivers/bus/arm-ccn.c:924:3: error: implicit declaration of function '__hrtimer_start_range_ns' [-Werror=implicit-function-declaration]
> > 
> > Today's -next fails to build both arm and arm64 allmodconfig due to the
> > above errors, introduced in commit ffa415245b8666c44d (bus: arm-ccn:
> > cpumask attribute).  Judging from the name of the symbol it appears that
> > the code is peering into hrtimer implementation details and indeed it
> > was removed in commit 58f1f803f1d6ef9 (hrtimer: Get rid of
> > __hrtimer_start_range_ns()) which has a commit message suggsting that
> > this has indeed been explicitly removed and no new references should be
> > added.
> 
> Right, the fix will be equivalent to
> 576b0704c9def6d54b3ae9e13b0b7567c713f568 "x86: perf: uncore: Use
> hrtimer_start()"
> 
> http://marc.info/?l=linux-kernel&m=142904610220085
> 
> Will post it in a second, but not sure who should take it? The arm-soc
> guys, as an additional ccn patch, or Thomas as part of his series?

Route it through the same tree as the commit which introduces the
__hrtimer_start_range_ns usage

Thanks,

	tglx
