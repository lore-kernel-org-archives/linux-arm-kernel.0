From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 16 Sep 2016 16:44:50 +0900
Subject: [PATCH v3] clk: let clk_disable() return immediately if clk is
 NULL
In-Reply-To: <194aebe5-38dd-f43d-fb4d-16ce592a68e8@gmail.com>
References: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
 <194aebe5-38dd-f43d-fb4d-16ce592a68e8@gmail.com>
Message-ID: <CAK7LNARaV6Ga5G1GnYf9hywrr+YwOqqm-v1AzBpfXtM4u9ofBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Michael,

2016-08-26 0:27 GMT+09:00 Florian Fainelli <f.fainelli@gmail.com>:
> On 08/24/2016 10:26 AM, Masahiro Yamada wrote:
>> Many of clk_disable() implementations just return for NULL pointer,
>> but this check is missing from some.  Let's make it tree-wide
>> consistent.  It will allow clock consumers to call clk_disable()
>> without NULL pointer check.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Greg Ungerer <gerg@uclinux.org>
>> Acked-by: Wan Zongshun <mcuos.com@gmail.com>
>> ---
>>
>> I came back after a long pause.
>> You can see the discussion about the previous version:
>> https://www.linux-mips.org/archives/linux-mips/2016-04/msg00063.html
>>
>>
>> Changes in v3:
>>   - Return only when clk is NULL.  Do not take care of error pointer.
>>
>> Changes in v2:
>>   - Rebase on Linux 4.6-rc1
>>
>>  arch/arm/mach-mmp/clock.c        | 3 +++
>>  arch/arm/mach-w90x900/clock.c    | 3 +++
>>  arch/blackfin/mach-bf609/clock.c | 3 +++
>>  arch/m68k/coldfire/clk.c         | 4 ++++
>>  arch/mips/bcm63xx/clk.c          | 3 +++
>


Gentle ping...


If you are not keen on this,
shall I split it per-arch and send to each arch subsystem?



-- 
Best Regards
Masahiro Yamada
