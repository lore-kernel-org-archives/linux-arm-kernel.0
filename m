From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 May 2016 14:42:02 +0200
Subject: [PATCH] ARM: at91/defconfig: sama5: add CONFIG_FHANDLE
In-Reply-To: <5731D49E.3080307@denx.de>
References: <572CC603.4000102@denx.de>
 <1462867383-31961-1-git-send-email-nicolas.ferre@atmel.com>
 <5731D49E.3080307@denx.de>
Message-ID: <5731D71A.5080500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/05/2016 14:31, Marek Vasut a ?crit :
> On 05/10/2016 10:03 AM, Nicolas Ferre wrote:
>> CONFIG_FHANDLE is listed as a mandatory kernel option for systemd. So
>> explicitly enable it to allow easy use of systemd userspace.
>>
>> Reported-by: Marek Vasut <marex@denx.de>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> Hi Marek,
> 
> Hi!
> 
>> It seems that on my side, CONFIG_FHANDLE is not selected automatically...
>> So I add this patch: can you tell me your thoughts?
> 
> Uh, weird, I tried this on next just now:
> 
> linux-2.6$ git describe HEAD
> next-20160510
> 
> linux-2.6$ export ARCH=arm ; export CROSS_COMPILE=arm-linux-gnueabi-
> 
> linux-2.6$ make sama5_defconfig ; grep FHANDLE .config
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/zconf.lex.c
>   SHIPPED scripts/kconfig/zconf.hash.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
> CONFIG_FHANDLE=y

Absolutely. The patch f76be61755c5 ("Make CONFIG_FHANDLE default y") has
been added in v4.6-rc2... while I was doing my tests on at91-next that
is based on v4.6-rc1 :-\

Anyway. It's in now. Thanks,

Bye,
   Nicolas

>>  arch/arm/configs/sama5_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
>> index 307f92b31e57..9cb1a85bb166 100644
>> --- a/arch/arm/configs/sama5_defconfig
>> +++ b/arch/arm/configs/sama5_defconfig
>> @@ -1,6 +1,7 @@
>>  # CONFIG_LOCALVERSION_AUTO is not set
>>  # CONFIG_SWAP is not set
>>  CONFIG_SYSVIPC=y
>> +CONFIG_FHANDLE=y
>>  CONFIG_IRQ_DOMAIN_DEBUG=y
>>  CONFIG_LOG_BUF_SHIFT=14
>>  CONFIG_CGROUPS=y
>>
> 
> 


-- 
Nicolas Ferre
