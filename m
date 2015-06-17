From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 17 Jun 2015 12:13:10 +0100
Subject: [PATCH 10/10] arm64/BUG: Show explicit backtrace for WARNs
In-Reply-To: <20150616144944.GF30522@arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
 <1434036566-9848-11-git-send-email-Dave.Martin@arm.com>
 <20150616144944.GF30522@arm.com>
Message-ID: <20150617111310.GD3651@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 03:49:44PM +0100, Will Deacon wrote:
> On Thu, Jun 11, 2015 at 04:29:24PM +0100, Dave P Martin wrote:
> > The generic slowpath WARN implementation prints a backtrace, but
> > the report_bug() based implementation does not, opting to print the
> > registers instead which is generally not as useful.
> > 
> > Ideally, report_bug() should be fixed to make the behaviour more
> > consistent, but in the meantime this patch generates a backtrace
> > directly from the arm64 backend instead so that this functionality
> > is not lost with the migration to report_bug().
> > 
> > As a side-effect, the backtrace will be outside the oops end
> > marker, but that's hard to avoid without modifying generic code.
> > 
> > This patch can go away if report_bug() grows the ability in the
> > future to generate a backtrace directly or call an arch hook at the
> > appropriate time.
> 
> Could you propose a patch to the core code, please? I'm happy to merge this
> in the interim, but it sounds like a simple oversight.

Already done[1], but it's late in the cycle and people are
understandably busy with other stuff.

The purpose of this arm64-specific patch is simply to decouple the
dependency.

None of this is urgent -- I plan to repost everything after the merge
window when people are less swamped.

[1] http://marc.info/?l=linux-kernel&m=143403763612397&w=2

[...]

Cheers
---Dave
