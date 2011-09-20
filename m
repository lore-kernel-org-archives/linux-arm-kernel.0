From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 20 Sep 2011 20:31:41 +0530
Subject: [PATCH 8/8] OMAP4: Fix the emif and dmm virtual mapping
In-Reply-To: <87r53gnzfh.fsf@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>	<1315459327-3285-9-git-send-email-santosh.shilimkar@ti.com>
	<87r53gnzfh.fsf@ti.com>
Message-ID: <4E78AAD5.6010906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 September 2011 11:26 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Fix the address overlap with Emulation domain (EMU).
>>
>> The previous mapping was entering into EMU mapping
>> and was not as per comments. Fix the mapping accordingly.
>>
>> [girishsg at ti.com: Helped fixing comments.]
>> Signed-off-by: Girish S G <girishsg@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/plat-omap/include/plat/io.h |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
>> index d72ec85..a2f7d31 100644
>> --- a/arch/arm/plat-omap/include/plat/io.h
>> +++ b/arch/arm/plat-omap/include/plat/io.h
>> @@ -228,12 +228,12 @@
>>  
>>  #define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
>>  						/* 0x4d000000 --> 0xfd200000 */
>> -#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF2_PHYS + OMAP4_L3_PER_IO_OFFSET)
>> +#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + SZ_1M)
> 
> IMO, this would be much clearer (and future proof) if you used
> '+ OMAP44XX_EMIF1_SIZE' instead of SZ_1M.
> 
ok.

>>  #define OMAP44XX_EMIF2_SIZE	SZ_1M
>>  
>>  #define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
>>  						/* 0x4e000000 --> 0xfd300000 */
>> -#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
>> +#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + SZ_1M)
> 
> and '+ OMAP44XX_EMIF2_SIZE' here.
> 
Will add OMAP44XX_EMIF_SIZE since 2 EMIFs instaces are and
suppose to be identical.Almost missed this email in other traffic.

Regards
Santosh
