From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 7 Oct 2010 06:03:18 +0900
Subject: [PATCH 6/7] sh: oprofile: Use perf-events oprofile backend
In-Reply-To: <20101006194507.GA30419@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
	<20101006183549.GW13563@erda.amd.com>
	<20101006194507.GA30419@console-pimps.org>
Message-ID: <20101006210317.GA7294@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 08:45:07PM +0100, Matt Fleming wrote:
> On Wed, Oct 06, 2010 at 08:35:49PM +0200, Robert Richter wrote:
> > On 04.10.10 16:44:24, Matt Fleming wrote:
> > > Now that we've got a generic perf-events based oprofile backend we might
> > > as well make use of it seeing as SH doesn't do anything special with its
> > > oprofile backend. Also introduce a new CONFIG_HW_PERF_EVENTS symbol so
> > > that we can fallback to using the timer interrupt for oprofile if the
> > > CPU doesn't support perf events.
> > > 
> > > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> > > ---
> > >  arch/sh/Kconfig            |   13 +++++
> > >  arch/sh/oprofile/Makefile  |    4 ++
> > >  arch/sh/oprofile/common.c  |  109 ++++---------------------------------------
> > >  arch/sh/oprofile/op_impl.h |   33 -------------
> > >  4 files changed, 28 insertions(+), 131 deletions(-)
> > >  delete mode 100644 arch/sh/oprofile/op_impl.h
> > 
> > This patch looks good.
> > 
> > We might merge it with patch 7/7.
> 
> This patch was broken out for Paul's benefit to ease review. If he's
> happy for me to merge this with 7/7 then that's fine with me.

Yes, no objections from me.
