From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 9 Aug 2011 10:54:34 +0100
Subject: [PATCH 00/10] ARM: perf: updates for 3.2
In-Reply-To: <20110809094234.GA3242@e102144-lin.cambridge.arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
	<20110809093505.GD3210@pulham.picochip.com>
	<20110809094234.GA3242@e102144-lin.cambridge.arm.com>
Message-ID: <20110809095434.GE3210@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 10:42:34AM +0100, Will Deacon wrote:
> On Tue, Aug 09, 2011 at 10:35:05AM +0100, Jamie Iles wrote:
> > Hi Will,
> 
> Hi Jamie,
> 
> > On Mon, Aug 08, 2011 at 06:16:01PM +0100, Will Deacon wrote:
> > > Hello,
> > > 
> > > This patch series contains a number of updates to the ARM PMU and perf
> > > code so that we can support mode exclusion, which is new in debug
> > > architecture 7.1 (as implemented by the Cortex-A15). Some of these
> > > updates also coincide with work to support System PMUs (PMUs that are
> > > not affine to a single CPU) but that is a larger body of work which will
> > > be posted separately at a later date.
> > > 
> > > The patches do the following:
> > > 
> > >   1.) Greatly simplify the PMU reservation mechanism so that the
> > >       handling of platform_devices is moved into perf.
> > >   2.) Cleans up the interrupt registration and some of the types used
> > >       to represent events and registers.
> > >   3.) Moves event indexing to start from zero rather than one, making
> > >       the code more readable and also easier to extend for mode
> > >       exclusion.
> > >   4.) Adds support for mode exclusion (user / kernel / hyp) and
> > >       implements this for Cortex-A15.
> > > 
> > > I've been running these patches since 3.0, so they've been tested on
> > > 1176, 11MPCore, Cortex-A5, Cortex-A9 and Cortex-A15 platforms.
> > 
> > A quick glance through them and they all look nice to me, but I can't 
> > get them to apply to any tree (next and master).  It looks like they're 
> > based on a tree with changes to the v7 perf support so I'm guessing it's 
> > your patches with A15 support.
> 
> Thanks for taking a look. The patches should just apply against -rc1:
> 
> http://www.linux-arm.org/git?p=linux-2.6-wd.git;a=shortlog;h=refs/heads/perf-updates

Yes, you're quite right.  I seem to have lost patches 1 and 4.  Probably 
finger trouble on my part!

Anyhow, I've pulled from your git tree and they appear to work nicely, 
so:

Acked-by: Jamie Iles <jamie@jamieiles.com>

Jamie
