From: will.deacon@arm.com (Will Deacon)
Date: Sat, 29 Oct 2011 14:59:27 +0100
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111028213850.GB7961@game.jcrosoft.org>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111028213850.GB7961@game.jcrosoft.org>
Message-ID: <20111029135927.GC25057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2011 at 10:38:50PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 15:43 Fri 28 Oct     , Will Deacon wrote:
> > arch_reset is a static inline function defined in mach/system.h and, as
> > such, is a blocker for the single zImage work.
> > 
> > This patch introduces an arm_arch_reset function pointer to which
> > platforms can assign their reset function rather than define it in the
> > header file.
> this is a great cleanup but I think this should be done in the soc_desc
> structure as propose before

Right, but that's not in mainline. Given that it looks like arm_pm_restart
is the hook we're going to go with then we can always move it into the SoC
descriptor later on.

Will
