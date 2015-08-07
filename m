From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Aug 2015 09:34:55 +0900
Subject: [PATCH v4 0/6] ARM: shmobile: r8a7740/sh73a0 DT Cache Handling
In-Reply-To: <CAMuHMdW5D2LGA=3+JDiAUhVtPmxk3ZJhAx3=JXFuAHBAgU_NTw@mail.gmail.com>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
 <20150806003511.GB17231@verge.net.au>
 <CAMuHMdW5D2LGA=3+JDiAUhVtPmxk3ZJhAx3=JXFuAHBAgU_NTw@mail.gmail.com>
Message-ID: <20150807003455.GB1145@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 09:17:38AM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 6, 2015 at 2:35 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Aug 05, 2015 at 10:58:04AM +0200, Geert Uytterhoeven wrote:
> >> This patch series add L1 and L2 cache descriptions to DT for r8a7740 and
> >> sh73a0, and migrates the shmobile DT-based generic r8a7740 and
> >> armadillo legacy platforms from calling l2x0_of_init() to the generic
> >> l2c OF initialization.
> 
> >> Dependencies:
> >>   - This series applies to renesas-devel-20150805-v4.2-rc5,
> >>   - Patch 2 depends on patch 1,
> >>   - Patch 4 depends on patch 2,
> 
> Sorry, "... on patch 3".
> 
> >>   - Patch 5 depends on patch 1 and on "ARM: 8395/1: l2c: Add support for
> >>     the "arm,shared-override" property" in arm/for-next,
> >>   - Patch 6 depends on patch 5.
> >>
> >> Given C code patches depending on DT patches in the same branch are
> >> frowned upon, I think it would be best if patch 1 (and patch 3, if
> >> anyone thinks we may fix the secondary CPU bringup issue during the next
> >> 3 months) are queued for v4.3. The other patches can be queued for
> >> 2016^H^H^H^Hv4.4.
> >
> > Sorry for surprising you with that merge-order requirement.
> 
> In theory it sounds fine, as DT and code are independent.
> Moving functionality from C to DT is something different...

I agree entirely. This is probably something that we should discuss
with the ARM SoC developers. But my feeling is that there should be
some scope for flexibility with regards to merge-order in such cases.

By which I mean we should try where possible, not to apply non-DT patches
on top of DT patches. But if circumstances arise where it seems to
be the best approach then we should to approach things pragmatically.

> > Unfortunately I am not comfortable with taking patch 1 for v4.3 because:
> > 1. Its now very late in the cycle
> 
> I understand.
> 
> > 2. There now seems to be some discussion around it.
> 
> Yeah, that's what v4s are for...
> 
> Let's wait and see if/when it settles...

Yes, lets.

> > I think I am happy to take the other patches for v4.4, now. But perhaps
> > I should wait for the discussion around patch 1 to conclude first?
> 
> Which other patches? Patch 3 has the same issue as patch 1. And all
> the rest depends on patch 1 or patch 3... So there's nothing left to
> apply yet...

Sorry for not being clearer. By other patches I meant patches 2 - 6 of this
series.  It seems that we should wait and I'm quite happy to do so.
