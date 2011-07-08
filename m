From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jul 2011 01:45:12 -0600 (MDT)
Subject: [PATCH v2 0/4] OMAP4: Add modulemode support to hwmod framework
	(part 2)
In-Reply-To: <1309557267-27165-1-git-send-email-b-cousson@ti.com>
References: <1309557267-27165-1-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107080142090.24181@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Here is the second part of the modulemode series. 
> The goal here is to do the cleanup on the clock nodes and PRCM macros
> that are not needed anymore by the hwmod data.
> Some macros are still needed because of clock data. It should be removed
> once the clock data will be cleaned.
> 
> Since the MMC pm_runtime is done, we can drop the TEMP hacks.
> 
> The series is based on for_3.1/6_hwmod_clkdm_fixes and tested
> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
> are definitively needed.
> 
> The patches are available here:
> git://gitorious.org/omap-pm/linux.git for_3.1/7_hwmod_modulemode

At this point, these don't seem like 3.1 material, mostly because this 
series removes main_clk entries.  This is going to cause problems 
retrieving the main_clk clockdomain, since the patch to retrieve it from 
the hwmod clkdm was dropped due to OMAP2/3 breakage.  Also, we should 
probably discuss whether there are additional implications to removing a 
module's main_clk, as opposed to setting it to a clock tree node closer to 
the root.


- Paul
