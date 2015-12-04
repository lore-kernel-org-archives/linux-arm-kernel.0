From: xuejiancheng@huawei.com (xuejiancheng)
Date: Fri, 4 Dec 2015 12:07:58 +0800
Subject: [PATCH v2 3/9] ARM: hisi: enable Hi3519 soc
In-Reply-To: <8647404.sBOFNLAMdU@wuerfel>
References: <1449110565-23590-1-git-send-email-xuejiancheng@huawei.com>
 <8647404.sBOFNLAMdU@wuerfel>
Message-ID: <5661119E.9060309@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2015/12/3 17:40, Arnd Bergmann wrote:
> On Thursday 03 December 2015 10:42:45 Jiancheng Xue wrote:
>> --- a/arch/arm/mach-hisi/Kconfig
>> +++ b/arch/arm/mach-hisi/Kconfig
>> @@ -12,6 +12,14 @@ if ARCH_HISI
>>  
>>  menu "Hisilicon platform type"
>>  
>> +config ARCH_HI3519
>> +       bool "Hisilicon Hi3519 Soc" if ARCH_MULTI_V7
>> +       select HAVE_ARM_ARCH_TIMER
>> +       select ARCH_HAS_RESET_CONTROLLER
>> +
>> +       help
>> +         Support for Hisilicon Hi3519 Soc
>> +
>>  config ARCH_HI3xxx
>>         bool "Hisilicon Hi36xx family" if ARCH_MULTI_V7
>>         select CACHE_L2X0
> 
> Do those need to be separate? I would just extend the Hi36xx
> to cover all Hi3xxx, if nothing in the platform code really
> depends on this.

For HI3519, there is really no special platform code. But HI35xx and HI36xx soc families
belong to different product lines in hisilicon. HI35xx family also composes of various
architectures socs(single core, smp and big-little). So I think it may be clear to have
separate arch definitions.

Could you give me more suggestions about this?  Thank you!

>> +
>> +static const char *const hi3519_compat[] __initconst = {
>> +       "hisilicon,hi3519",
>> +       NULL,
>> +};
>> +
>> +DT_MACHINE_START(HI3519_DT, "Hisilicon Hi3519 (Flattened Device Tree)")
>> +       .dt_compat      = hi3519_compat,
>> +MACHINE_END
> 
> Also drop the "(Flattened Device Tree)" part of the name, we don't
> support any other kind anyway.

OK.

> 
> 	Arnd
> 
> .
> 
