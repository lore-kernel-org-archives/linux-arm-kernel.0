From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 27 Oct 2012 03:02:10 +0000 (UTC)
Subject: [PATCHv9 0/8] ARM: OMAP4: core retention support
In-Reply-To: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1210270254220.27071@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero, Kevin,

On Thu, 18 Oct 2012, Tero Kristo wrote:

> Changes compared to previous version:
> - rebased on top of 3.7-rc1
> - applies on top of latest func pwrst code (v6)
> - added back patch #1 to this set (it wasn't queued yet after all)

That's because there was an interaction between it and the omap-serial 
changes in the last merge window that caused several failures :-( 
Hopefully it's good to go now...

> - added patch #7 for fixing a bug in the functional pwrst code
> - added patch #8 for fixing a regression with MUSB PHY power handling
>   (not quite sure if this is the correct way to fix this or not)
> 
> Tested with omap4460 gp panda + omap4430 emu blaze boards, with cpuidle +
> suspend.
> 
> Branch also available here:
> git://gitorious.org/~kristo/omap-pm/omap-pm-work.git
> branch: mainline-3.7-rc1-omap4-ret-v9

Looks like only patches #5 and #7 have dependencies on Jean's functional 
powerstate series, so those should be postponed until that rework is 
complete.  Looks like #6 and #8 should go in via Tony, assuming there are 
no dependencies on the rest of the patches.  Have just queued #1 for 3.8 
and kicked off a test to ensure that everything is working.

As far as the rest go, Kevin, do you want to take them? 


- Paul
