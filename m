From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 28 Jan 2016 09:41:23 +0800
Subject: [PATCH 14/15] Revert "bus: uniphier: allow only built-in driver"
In-Reply-To: <CAK7LNAR=E5kYzsO9=YDeAVzp9cLWd9C8ANeVGJOvM=BSM4aTjg@mail.gmail.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-15-git-send-email-wangkefeng.wang@huawei.com>
 <CAK7LNAR=E5kYzsO9=YDeAVzp9cLWd9C8ANeVGJOvM=BSM4aTjg@mail.gmail.com>
Message-ID: <56A971C3.6000608@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

On 2016/1/27 21:48, Masahiro Yamada wrote:
> 2016-01-27 13:27 GMT+09:00 Kefeng Wang <wangkefeng.wang@huawei.com>:
>> This reverts commit 326ea45aa827da6686c78b5907f9839f91ef5782.
>>
>> After covering to use helper of_platform_default_populate() to
>> populate the default bus, no error in build uniphier driver as
>> a module.
> 
> This statement is weird.
> There is no error for building this driver as a module
> at the point of v4.5-rc1.

Yes, but after drop export of_default_bus_match_table in patchset(15/15),
we will meet build issue, so the statement can be changed to
------------
After covering to use helper of_platform_default_populate() to
populate the default bus, this driver can be safely as a tristate
one, no error in build uniphier driver as a module once we drop
export of_default_bus_match_table in later patch.
------------
> 
> The of_platform_default_populate() conversion (11/15) is unrelated
> to fixing the build error.
> 
> BTW, I had already posted an equivalent patch a few days before:
> 
> https://patchwork.kernel.org/patch/8096991/
> 
I didn't notice this before, it is ok for me to use your patch, or I will send
a new one with update changlog, thanks for your review.

> 
> 
> 
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>  drivers/bus/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>> index 129d47b..9a92c07 100644
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@ -132,7 +132,7 @@ config SUNXI_RSB
>>           and AC100/AC200 ICs.
>>
>>  config UNIPHIER_SYSTEM_BUS
>> -       bool "UniPhier System Bus driver"
>> +       tristate "UniPhier System Bus driver"
>>         depends on ARCH_UNIPHIER && OF
>>         default y
>>         help
>> --
>> 2.6.0.GIT
>>
> 
> 
