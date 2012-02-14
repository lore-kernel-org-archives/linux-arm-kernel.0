From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Feb 2012 11:13:05 +0000
Subject: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as
 part of reserve callback
In-Reply-To: <20120210191926.GV1426@atomide.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
 <20120210191926.GV1426@atomide.com>
Message-ID: <20120214111305.GF15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2012 at 11:19:26AM -0800, Tony Lindgren wrote:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [120202 05:33]:
> > arm_memblock_steal() is not suppose to be used outside ->reserve callback.
> > OMAP barrier errata code was using it outside reserve callback and hence
> > it was broken.
> > 
> > Move the allocation as part of ->reserve callback to fix the it.
> 
> Please update this to mention again commit that changed things
> around for arm_memblock_steal() so it's clear why this is needed
> as a fix.

It's more the case that this whole errata fix was broken right from the
start, and the change to arm_memblock_steal() just enforced correct usage
of the APIs.

So, really the arm_memblock_steal() change has nothing to do with this.
