From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 7 Nov 2012 12:11:33 +0200
Subject: [PATCHv9 2/8] ARM: OMAP4: PM: add errata support
In-Reply-To: <87d2zq761g.fsf@deeprootsystems.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-3-git-send-email-t-kristo@ti.com>
 <87zk2vekye.fsf@deeprootsystems.com>  <87d2zq761g.fsf@deeprootsystems.com>
Message-ID: <1352283093.2406.2.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-11-06 at 13:52 -0800, Kevin Hilman wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > Tero Kristo <t-kristo@ti.com> writes:
> >
> >> Added similar PM errata flag support as omap3 has. This should be used
> >> in similar manner, set the flags during init time, and check the flag
> >> values during runtime.
> >>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >
> > These allow basic suspend/resume to work on 4460/Panda-ES, so I'm going
> > to queue these up as fixes.
> >
> > However, since they're not technically regressions, it may be too late
> > to get them in for v3.7, but they'll be in for v3.8 for sure.
> 
> To be more specific, I'm planning on queuing patches 2, 3 and 6 as fixes
> for v3.8 (branch: for_3.8/fixes/pm).
> 
> Paul has already queued patch 1, so that leaves patches 4, 5, 7 & 8.
> 
> I think we can get this series in for v3.8 if we drop the functional
> pwrst dependency.  To test, I dropped patches 5 & 7, and tested on
> 4430/Panda and 4460/Panda-ES (with latest mainline u-boot) and CORE
> is hitting retention just fine in suspend.
> 
> If you can respin patch 8 based on the feedback from Felipe, I'll queue
> up patches 4 & 8 for v3.8 as well, then we'll at least have CORE
> retention in suspend in mainline.  Then, the  rest can be done when
> functional pwrsts are ready.

Yea, I can do that on Friday once I get back home, I am travelling
currently.

> 
> Kevin
> 
> P.S. do you have any patches to add any OMAP4 CPUidle support for CORE
>      retention?

No, cpuidle core ret should work with this set already. Not sure what
happens without the func pwrst patches, I have not tested with that
setup lately. I can try this out on Friday as well.

-Tero
