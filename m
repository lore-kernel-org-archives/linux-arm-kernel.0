From: marex@denx.de (Marek Vasut)
Date: Tue, 10 May 2016 14:46:52 +0200
Subject: [PATCH] ARM: at91/defconfig: sama5: add CONFIG_FHANDLE
In-Reply-To: <5731D71A.5080500@atmel.com>
References: <572CC603.4000102@denx.de>
 <1462867383-31961-1-git-send-email-nicolas.ferre@atmel.com>
 <5731D49E.3080307@denx.de> <5731D71A.5080500@atmel.com>
Message-ID: <5731D83C.3030308@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 02:42 PM, Nicolas Ferre wrote:
> Le 10/05/2016 14:31, Marek Vasut a ?crit :
>> On 05/10/2016 10:03 AM, Nicolas Ferre wrote:
>>> CONFIG_FHANDLE is listed as a mandatory kernel option for systemd. So
>>> explicitly enable it to allow easy use of systemd userspace.
>>>
>>> Reported-by: Marek Vasut <marex@denx.de>
>>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> ---
>>> Hi Marek,
>>
>> Hi!
>>
>>> It seems that on my side, CONFIG_FHANDLE is not selected automatically...
>>> So I add this patch: can you tell me your thoughts?
>>
>> Uh, weird, I tried this on next just now:
>>
>> linux-2.6$ git describe HEAD
>> next-20160510
>>
>> linux-2.6$ export ARCH=arm ; export CROSS_COMPILE=arm-linux-gnueabi-
>>
>> linux-2.6$ make sama5_defconfig ; grep FHANDLE .config
>>   HOSTCC  scripts/basic/fixdep
>>   HOSTCC  scripts/kconfig/conf.o
>>   SHIPPED scripts/kconfig/zconf.tab.c
>>   SHIPPED scripts/kconfig/zconf.lex.c
>>   SHIPPED scripts/kconfig/zconf.hash.c
>>   HOSTCC  scripts/kconfig/zconf.tab.o
>>   HOSTLD  scripts/kconfig/conf
>> #
>> # configuration written to .config
>> #
>> CONFIG_FHANDLE=y
> 
> Absolutely. The patch f76be61755c5 ("Make CONFIG_FHANDLE default y") has
> been added in v4.6-rc2... while I was doing my tests on at91-next that
> is based on v4.6-rc1 :-\
> 
> Anyway. It's in now. Thanks,

Cool, thanks :)

-- 
Best regards,
Marek Vasut
