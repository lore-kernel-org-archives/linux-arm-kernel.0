From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Jan 2013 12:42:10 +0100
Subject: [PATCH 7/9] ARM: at91/at91_dt_defconfig: remove memory
 specification to cmdline
In-Reply-To: <20130123102057.GJ7360@game.jcrosoft.org>
References: <cover.1358934163.git.nicolas.ferre@atmel.com>
 <2e06e92c758b768baaacc061aafa7f710b74ea02.1358934163.git.nicolas.ferre@atmel.com>
 <20130123102057.GJ7360@game.jcrosoft.org>
Message-ID: <50FFCC92.2080906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 11:20 AM, Jean-Christophe PLAGNIOL-VILLARD :
> On 10:48 Wed 23 Jan     , Nicolas Ferre wrote:
>> No need for this cmdline option as we are using DT.
>> Moreover this defconfig is targeted to multiple SoC/boards: this option
>> was nonsense.
> just keep the console the rest is a nonsense too
> 
> as on 9g45 the initrd will be at 0x7xxxxxxx

BTW, how do you mix 9g45 with other sam9's in this defconfig: it is not
possible due to this difference in address rage, it not it?

In this case, should we remove the
CONFIG_SOC_AT91SAM9G45=y
from this at91_dt_defconfig?

> the console too but as the patch serie to support via DT is not yet mainline
> we can keep it
> 
> Best Regards,
> J.
>>
>> Reported-by: Josh Wu <josh.wu@atmel.com>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>  arch/arm/configs/at91_dt_defconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
>> index b175577..a353ff6 100644
>> --- a/arch/arm/configs/at91_dt_defconfig
>> +++ b/arch/arm/configs/at91_dt_defconfig
>> @@ -31,7 +31,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
>>  CONFIG_ZBOOT_ROM_BSS=0x0
>>  CONFIG_ARM_APPENDED_DTB=y
>>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>> -CONFIG_CMDLINE="mem=128M console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
>> +CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
>>  CONFIG_KEXEC=y
>>  CONFIG_AUTO_ZRELADDR=y
>>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set

Bye,
-- 
Nicolas Ferre
