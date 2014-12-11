From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 11 Dec 2014 16:57:11 +0000
Subject: [PATCH 4/4] ARM: add 32bit support to GICv3
In-Reply-To: <5489BAEF.5050809@arm.com>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
 <1418307788-17977-5-git-send-email-jean-philippe.brucker@arm.com>
 <20141211143205.GP11285@n2100.arm.linux.org.uk>
 <5489BAEF.5050809@arm.com>
Message-ID: <20141211165711.GA17509@e106794-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 03:40:31PM +0000, Marc Zyngier wrote:
> On 11/12/14 14:32, Russell King - ARM Linux wrote:
> > On Thu, Dec 11, 2014 at 02:23:08PM +0000, Jean-Philippe Brucker wrote:
> >> +#ifndef __ASM_ARCH_GICV3_H
> >> +#define __ASM_ARCH_GICV3_H
> >> +
> >> +#ifndef __ASSEMBLY__
> >> +
> >> +#include <asm/io.h>
> > 
> > This should be linux/io.h
> 
> Also, you should probably move the #ifndef down to the level of the
> inline functions. The #defines are perfectly usable in assembly context.
> 

This would require a change in the definition of __ACCESS_CP15, in order
to distinguish between inlined parameter '%0' and explicit registers.
I don't see any pleasant ways to do this, apart from adding a 'reg'
argument to all those #defines.
Furthermore, all other cp15 accesses from assembly on the arm/ side seem
to use raw opcodes, instead of macro names.

Thanks,
Jean
