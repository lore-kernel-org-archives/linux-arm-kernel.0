From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 21 Jun 2013 09:23:20 +0100
Subject: [PATCH] of: Specify initrd location using 64-bit
In-Reply-To: <51C3D8E7.5030601@synopsys.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C3D8E7.5030601@synopsys.com>
Message-ID: <51C40D78.4040603@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/13 05:39, Vineet Gupta wrote:
> Hi Santosh,
> 
> On 06/21/2013 06:22 AM, Santosh Shilimkar wrote:
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
>> Cc: James Hogan <james.hogan@imgtec.com>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: x86 at kernel.org
>> Cc: arm at kernel.org
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Max Filippov <jcmvbkbc@gmail.com>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: bigeasy at linutronix.de
>> Cc: robherring2 at gmail.com
>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
>>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-c6x-dev at linux-c6x.org
>> Cc: linux-mips at linux-mips.org
>> Cc: linuxppc-dev at lists.ozlabs.org
>> Cc: linux-xtensa at linux-xtensa.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arc/mm/init.c            |    3 +--
>>  arch/arm/mm/init.c            |    2 +-
>>  arch/arm64/mm/init.c          |    3 +--
>>  arch/c6x/kernel/devicetree.c  |    3 +--
>>  arch/metag/mm/init.c          |    3 +--
>>  arch/microblaze/kernel/prom.c |    3 +--
>>  arch/mips/kernel/prom.c       |    3 +--
>>  arch/openrisc/kernel/prom.c   |    3 +--
>>  arch/powerpc/kernel/prom.c    |    3 +--
>>  arch/x86/kernel/devicetree.c  |    3 +--
>>  arch/xtensa/kernel/setup.c    |    3 +--
>>  drivers/of/fdt.c              |   10 ++++++----
>>  include/linux/of_fdt.h        |    3 +--
>>  13 files changed, 18 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
>> index 4a17736..3640c74 100644
>> --- a/arch/arc/mm/init.c
>> +++ b/arch/arc/mm/init.c
>> @@ -157,8 +157,7 @@ void __init free_initrd_mem(unsigned long start, unsigned long end)
>>  #endif
>>  
>>  #ifdef CONFIG_OF_FLATTREE
>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>> -					    unsigned long end)
>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>  {
>>  	pr_err("%s(%lx, %lx)\n", __func__, start, end);
>>  }
> 
> To avoid gcc warnings, you need to fix the print format specifiers too.

The same thing goes for arch/metag too.

Cheers
James
