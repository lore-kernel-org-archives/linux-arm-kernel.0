From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 3 May 2012 16:52:32 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: watchdog: fix !PM boot crash, disarm timer
 after hwmod reset
In-Reply-To: <4FA2CC48.8020302@deeprootsystems.com>
References: <1334353873-15972-1-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1204201451510.11306@utopia.booyaka.com>
 <4FA2CC48.8020302@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1205031652070.20926@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, 3 May 2012, Kevin Hilman wrote:

> On 04/20/2012 01:59 PM, Paul Walmsley wrote:
> 
> [...]
> 
> > This looks great, looks like it will finally fix this longstanding bug.  I
> > think Santosh hit it too a long time ago, so I suspect he will be happy
> > too.
> > 
> > One comment: I think that omap2_wd_timer_reset() needs to be updated in
> > light of commit 3c55c1baffa5f719eb2ae9729088bc867f972f53 ("ARM: OMAP2+:
> > hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for
> > reset status"").  I did this here.  It's passed basic build testing but
> > haven't tried booting it yet.  Care to take a look and see if you have any
> > comments?  It's also available in the 'hwmod_devel_a_3.5' branch of
> > git://git.pwsan.com/linux-2.6
> 
> I just noticed a compile warning with your updated version:
> 
> /work/kernel/omap/pm/arch/arm/mach-omap2/wd_timer.c: In function
> 'omap2_wd_timer_reset':
> /work/kernel/omap/pm/arch/arm/mach-omap2/wd_timer.c:78:6: warning: unused
> variable 'v' [-Wunused-variable]
> 
> The diff below on top of your patch fixes it.

Thanks, just rolled this into the patch and added some credit.


- Paul
