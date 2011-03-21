From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Mar 2011 15:48:33 +0000
Subject: [PATCHv4 3/3] ARM: mx51: Add support for low power suspend on MX51
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA1BC0AF@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1300461684-21775-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1300461684-21775-2-git-send-email-Dinh.Nguyen@freescale.com>
	<1300461684-21775-3-git-send-email-Dinh.Nguyen@freescale.com>
	<20110318152502.GO29758@n2100.arm.linux.org.uk>
	<56132A77AB93C141BF06E6B96CA6CFEA1BC0AF@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <20110321154833.GD4340@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 02:53:21PM +0000, Nguyen Dinh-R00091 wrote:
> >On Fri, Mar 18, 2011 at 10:21:24AM -0500, Dinh.Nguyen at freescale.com wrote:
> >> +#include <linux/suspend.h>
> >> +#include <linux/clk.h>
> >> +#include <asm/mach/map.h>
> >> +#include <asm/cacheflush.h>
> >> +#include <asm/tlb.h>
> >> +#include <mach/system.h>
> >> +#include "crm_regs.h"
> >
> >Why does the code below require asm/mach/map.h ?
> 
> map.h can be replaced by linux/io.h for the __raw_writel().
> 
> >Why does it require asm/tlb.h ?
> 
> asm/tlb is for the local_flush_tlb_all() call.

I think you want asm/tlbflush.h rather than the tlb shootdown stuff in
asm/tlb.h.
