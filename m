From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 24 Aug 2017 14:59:34 +0200
Subject: Intermittent memory corruption with v4.13-rc6+ and earlier
In-Reply-To: <20170824123647.GA19698@leverpostej>
References: <20170824113743.GA14737@leverpostej>
 <20170824114833.GH5943@dhcp22.suse.cz>
 <20170824123647.GA19698@leverpostej>
Message-ID: <20170824125934.GL5943@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 24-08-17 13:36:48, Mark Rutland wrote:
> On Thu, Aug 24, 2017 at 01:48:34PM +0200, Michal Hocko wrote:
> > On Thu 24-08-17 12:37:43, Mark Rutland wrote:
> > > Hi,
> > > 
> > > I'm chasing intermittent memory corruption bugs seen at least on rc5,
> > > rc6, and yesterday's HEAD (98b9f8a4549909c6), on arm64. 
> > > 
> > > It looks like we make use of dangling references to a freed struct file,
> > > which is caught by KASAN. Without KASAN, I see a number of other
> > > intermittent issues that I suspect are the result of this memory
> > > corruption. I've included an example splat below, complete with KASAN's
> > > alloc/free traces at the end of this mail.
> > 
> > Is it possible this is the same issue as the one fixed by
> > http://lkml.kernel.org/r/20170823211408.31198-1-ebiggers3 at gmail.com?
> 
> That sounds plausible, and so far the fix seems to help. Thanks for the
> pointer!
> 
> I'll leave that running for a while, just in case.

Thanks!
-- 
Michal Hocko
SUSE Labs
