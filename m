From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Dec 2014 15:40:31 +0000
Subject: [PATCH 4/4] ARM: add 32bit support to GICv3
In-Reply-To: <20141211143205.GP11285@n2100.arm.linux.org.uk>
References: <1418307788-17977-1-git-send-email-jean-philippe.brucker@arm.com>
 <1418307788-17977-5-git-send-email-jean-philippe.brucker@arm.com>
 <20141211143205.GP11285@n2100.arm.linux.org.uk>
Message-ID: <5489BAEF.5050809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/14 14:32, Russell King - ARM Linux wrote:
> On Thu, Dec 11, 2014 at 02:23:08PM +0000, Jean-Philippe Brucker wrote:
>> +#ifndef __ASM_ARCH_GICV3_H
>> +#define __ASM_ARCH_GICV3_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <asm/io.h>
> 
> This should be linux/io.h

Also, you should probably move the #ifndef down to the level of the
inline functions. The #defines are perfectly usable in assembly context.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
