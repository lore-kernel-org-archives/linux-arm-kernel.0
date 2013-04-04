From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 19:16:50 +0530
Subject: [PATCH v2 11/18] ARM: OMAP5: PM: Add L2 memory power down support
In-Reply-To: <87ehertjpf.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-12-git-send-email-santosh.shilimkar@ti.com>
 <87ehertjpf.fsf@linaro.org>
Message-ID: <515D844A.4070407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 02:28 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> When the entire MPUSS cluster is powered down in device off state, L2 cache
>> memory looses it's content and hence while targetting such a state,
>> l2 cache needs to be flushed to main memory.
>>
>> Add the necessary low power code support for the same.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-secure.h     |    1 +
>>  arch/arm/mach-omap2/sleep_omap4plus.S |   21 +++++++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
>> index 1739468..a171a5a 100644
>> --- a/arch/arm/mach-omap2/omap-secure.h
>> +++ b/arch/arm/mach-omap2/omap-secure.h
>> @@ -47,6 +47,7 @@
>>  #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
>>  #define OMAP5_MON_CACHES_CLEAN_INDEX	0x103
>>  #define OMAP5_MON_AUX_CTRL_INDEX	0x107
>> +#define OMAP5_MON_L2AUX_CTRL_INDEX	0x104
> 
> this #define is not used in this patch.
> 
Yep. Will drop above hunk.
I forgot to drop this one after dropping the L2X0
setting from last version. Its no longer needed on OMAP5
ES2.0.

Regards,
Santosh
