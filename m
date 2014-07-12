From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 09:53:17 -0700
Subject: [PATCH v4 0/4] ARM: pxa: Fix out of vmalloc space bug
In-Reply-To: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20140712165317.GH3954@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 01:00:35PM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch set reworks Ezequiel Garcia's previous fix [1] of an out of vmalloc
> space bug on PXA2[57]x platforms caused by an attempt to map the start of
> physical uncached outside of the vmalloc space.
> 
> This first three patches perform a couple of cleanups, and the last patch
> fixes the problem. I've decided to map the memory at address 0xfe000000 to
> minimize changes to the code, but this causes a bit of fragmentation of
> vmalloc space. I could map it to the very end of vmalloc space (0xfef00000)
> instead if preferred, which would involve replacing a mov by an ldr in
> pxa2[57]x_finish_suspend and pm_enter_standby_start.
> 
> I've tested the patch set on a PXA270-based system.
> 
> [1] https://lkml.org/lkml/2013/11/28/474
> 
> Compared to v3, the patches have been rebased on top of v3.16-rc5. Olof, could
> you please pick them up for v3.17 ?

Thanks, applied to next/cleanup (since we're collecting some of the for-3.17
fixes there too.


-Olof
