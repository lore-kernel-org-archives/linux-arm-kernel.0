From: vinayakm.list@gmail.com (vinayak)
Date: Mon, 22 Apr 2013 23:48:51 +0530
Subject: [PATCH] mm: add an option to disable bounce
In-Reply-To: <20130422174712.GS14496@n2100.arm.linux.org.uk>
References: <1366644180-6140-1-git-send-email-vinayakm.list@gmail.com>
 <20130422174712.GS14496@n2100.arm.linux.org.uk>
Message-ID: <51757F0B.1090104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 April 2013 11:17 PM, Russell King - ARM Linux wrote:

> On Mon, Apr 22, 2013 at 08:53:00PM +0530, vinayakm.list at gmail.com wrote:
>> From: Vinayak Menon <vinayakm.list@gmail.com>
>>
>> There are times when HIGHMEM is enabled, but
>> we don't prefer CONFIG_BOUNCE to be enabled.
>> CONFIG_BOUNCE can reduce the block device
>> throughput, and this is not ideal for machines
>> where we don't gain much by enabling it. So
>> provide an option to deselect CONFIG_BOUNCE. The
>> observation was made while measuring eMMC throughput
>> using iozone on an ARM device with 1GB RAM.
>>
>> Signed-off-by: Vinayak Menon <vinayakm.list@gmail.com>
>> ---
>>  mm/Kconfig |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 3bea74f..29f9736 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -263,8 +263,14 @@ config ZONE_DMA_FLAG
>>  	default "1"
>>  
>>  config BOUNCE
>> +	bool "Enable bounce buffers"
>>  	def_bool y
>>  	depends on BLOCK && MMU && (ZONE_DMA || HIGHMEM)
> 
> I don't think this is correct.  You shouldn't use "bool" with "def_bool".
> Sure, add the "bool", but also change "def_bool" to "default".


Yes. I will change it to "default" and this looks to be correct
even from the definition in kconfig-language.txt. But I see other
instances in mm/Kconfig, where bool and def_bool are used together. When
I had tested this patch with def_bool, it worked as expected.
