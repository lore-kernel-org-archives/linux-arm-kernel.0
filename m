From: dmitry_eremin@mentor.com (Dmitry Eremin-Solenikov)
Date: Fri, 1 Nov 2013 15:21:07 +0400
Subject: [PATCH 4/4] ARM: sa1100: switch to COMMON_CLK framework
In-Reply-To: <20131101105933.GL16735@n2100.arm.linux.org.uk>
References: <1383303131-29550-1-git-send-email-dmitry_eremin@mentor.com>
 <1383303131-29550-4-git-send-email-dmitry_eremin@mentor.com>
 <20131101105933.GL16735@n2100.arm.linux.org.uk>
Message-ID: <52738EA3.2010701@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/13 14:59, Russell King - ARM Linux wrote:
> On Fri, Nov 01, 2013 at 02:52:11PM +0400, Dmitry Eremin-Solenikov wrote:
>> +#include <linux/kernel.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
>> +
>> +#include <mach/hardware.h>
> 
> If the aim of this patch set is to move SA11x0 towards multiplatform,
> then this has just failed with the above include.  It would be better
> not to try this without first solving the problem of the SoC register
> definitions.

OK, still learning "new ARM" ways. Is it ok to remap fixed addresses in
that file?

And second question: what would be better: to leave that code as is,
or to convert that to 3M6864/32k768 multiplexer (TUCR bit) +
enable/disable (GAFR/GPDR)? I ain't sure that all other TUCR modes
were ever used.

-- 
With best wishes
Dmitry
