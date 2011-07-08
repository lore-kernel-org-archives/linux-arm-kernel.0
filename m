From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jul 2011 01:33:32 -0600 (MDT)
Subject: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
In-Reply-To: <20110707154834.GP15815@atomide.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
	<4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com>
	<E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE32@staex7mb2.telecom.sna.samsung.com>
	<20110707121040.GF15815@atomide.com>
	<E9AF1FACCF71F448B55E58D9AED1B0F40E626BEE34@staex7mb2.telecom.sna.samsung.com>
	<20110707154834.GP15815@atomide.com>
Message-ID: <alpine.DEB.2.00.1107080124480.24181@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jul 2011, Tony Lindgren wrote:

> Well sounds like we might be able to get rid of CHIP_IS in the *_data.c 
> files if we use SoC variant specific lists. Of course Paul might have 
> some other ideas here.

Sounds like a reasonable approach to me for the data files.  The 
powerdomain, clockdomain, and hwmod data would be good places to start.  
It will come at the cost of some extra memory and duplicated data - 
consider mach-omap2/clockdomains2xxx_3xxx_data.c. But given the zeitgeist, 
it's probably worth it to avoid patching that data when we need to 
generalize.

Unfortunately, we'll still have the macro naming and file naming parts of 
the problem.  Not sure if there's an easy fix for those, though.


- Paul
