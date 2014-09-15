From: balbi@ti.com (Felipe Balbi)
Date: Mon, 15 Sep 2014 14:29:46 -0500
Subject: [PATCH 30/35] irqchip: add irq-omap-intc.h header
In-Reply-To: <20140911210800.GI18849@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-31-git-send-email-balbi@ti.com>
 <20140911210800.GI18849@atomide.com>
Message-ID: <20140915192946.GG20655@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 11, 2014 at 02:08:01PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [140728 14:19]:
> > OMAP INTC irqchip driver will be moved under
> > drivers/irqchip/ soon but we still have a dependency
> > with mach-omap2 when it comes to idle functions.
> > 
> > In order to make it easy to share those function
> > prototypes with OMAP PM code, we introduce this new
> > header.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-3430sdp.c        |  1 +
> >  arch/arm/mach-omap2/board-am3517crane.c    |  1 +
> >  arch/arm/mach-omap2/board-am3517evm.c      |  1 +
> >  arch/arm/mach-omap2/board-cm-t35.c         |  1 +
> >  arch/arm/mach-omap2/board-cm-t3517.c       |  1 +
> >  arch/arm/mach-omap2/board-devkit8000.c     |  1 +
> >  arch/arm/mach-omap2/board-ldp.c            |  1 +
> >  arch/arm/mach-omap2/board-omap3beagle.c    |  1 +
> >  arch/arm/mach-omap2/board-omap3logic.c     |  1 +
> >  arch/arm/mach-omap2/board-omap3pandora.c   |  1 +
> >  arch/arm/mach-omap2/board-omap3stalker.c   |  1 +
> >  arch/arm/mach-omap2/board-omap3touchbook.c |  1 +
> >  arch/arm/mach-omap2/board-overo.c          |  1 +
> >  arch/arm/mach-omap2/board-rx51.c           |  1 +
> >  arch/arm/mach-omap2/board-ti8168evm.c      |  1 +
> >  arch/arm/mach-omap2/common.h               |  9 ---------
> >  arch/arm/mach-omap2/cpuidle34xx.c          |  1 +
> >  arch/arm/mach-omap2/irq.c                  |  1 +
> >  arch/arm/mach-omap2/pm24xx.c               |  1 +
> >  arch/arm/mach-omap2/pm34xx.c               |  1 +
> >  include/linux/irqchip/irq-omap-intc.h      | 32 ++++++++++++++++++++++++++++++
> >  21 files changed, 51 insertions(+), 9 deletions(-)
> 
> I ended up setting up another branch without this patch
> at omap-for-v3.12/intc-v2. It now has dependency to the
> SoC changes from Nishant and the const cleanup fix from Uwe.
> 
> This patch is not needed, let's leave this out, the functions

so, if we don't add that header, we will have to include soc.h and
common.h with full (relative) path from drivers/irqchip/irq-omap-intc.c.
IOW:

#include "../../arch/arm/mach-omap2/common.h"

Neither soc.h nor common.h are part of the include path. I'd rather not
go down that route and just add this extra header. Even if you ask me to
move soc.h and common.h under <asm/mach/{soc,common}.h> we will already
have to modify every board file anyway.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140915/6a18c2e2/attachment.sig>
