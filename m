From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Sep 2012 13:49:12 +0200
Subject: [PATCH V3 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <20120906111152.GE858@mudshark.cambridge.arm.com>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-4-git-send-email-gregory.clement@free-electrons.com>
 <20120906111152.GE858@mudshark.cambridge.arm.com>
Message-ID: <50488DB8.1010007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 01:11 PM, Will Deacon wrote:
> On Wed, Sep 05, 2012 at 02:44:34PM +0100, Gregory CLEMENT wrote:
>> Aurora Cache Controller was designed to be compatible with the ARM L2
>> Cache Controller. It comes with some difference or improvement such
>> as:
>> - no cache id part number available through hardware (need to get it
>>   by the DT).
>> - always write through mode available.
>> - two flavors of the controller outer cache and system cache (meaning
>>   maintenance operations on L1 are broadcasted to the L2 and L2
>>   performs the same operation).
>> - in outer cache mode, the cache maintenance operations are improved and
>>   can be done on a range inside a page and are not limited to a cache
>>   line.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
>> Tested-and-reviewed-by: Lior Amsalem <alior@marvell.com>
>>
>> Cc: Barry Song <21cnbao@gmail.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> ---
>>  arch/arm/include/asm/hardware/cache-aurora-l2.h |   55 ++++++
>>  arch/arm/include/asm/hardware/cache-l2x0.h      |    4 +
>>  arch/arm/mm/cache-l2x0.c                        |  237 +++++++++++++++++++++--
>>  3 files changed, 283 insertions(+), 13 deletions(-)
>>  create mode 100644 arch/arm/include/asm/hardware/cache-aurora-l2.h
> 
> This is looking pretty good now:
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> 

Thanks. I guess you also reviewed patches 1 and 2, don't you?

And then where should I push my series?

Patches 1,2 and 3 depend of ARM subsystem so they should be submitted
using Russell King's patch state system. Patches 4 and 5 are more soc
specific and should go to marvell tree and then arm-soc. But patches 4
and 5 are meaningless if the first patches are not applied. What is the
good practice?

> Cheers,
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
