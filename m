From: cooloney@gmail.com (Bryan Wu)
Date: Mon, 5 Aug 2013 15:52:35 -0700
Subject: [PATCH] leds: leds-netxbig: depends on ARCH_KIRKWOOD
In-Reply-To: <20130803141200.GI5882@titan.lakedaemon.net>
References: <1375369655-1310-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375479274-9942-1-git-send-email-simon.guinot@sequanux.org>
 <20130803141200.GI5882@titan.lakedaemon.net>
Message-ID: <CAK5ve-+aeB1S0E=HAxPyVwoQ0WOEREQC+XnAeHX4bU_eavsP2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 3, 2013 at 7:12 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Aug 02, 2013 at 11:34:34PM +0200, Simon Guinot wrote:
>> With the DT conversion, the board Kconfig symbols MACH_ are going to be
>> removed. In order to prepare this removal, this patch replaces alls the
>> machines dependencies for leds-netxbig by ARCH_KIRKWOOD.
>>
>> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
>> ---
>> Thomas,
>>
>> Please, insert this patch in your series before the patch named:
>> [PATCHv2 7/9] ARM: kirkwood: convert LaCie Net{2, 5}Big v2 platforms to DT
>
> Nah, this should go through linux-leds.
>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
>

I can merge this patch through my tree but when will that kirkwood
patch be merged?
How about merge this with those kirkwood patches with my ack:

Acked-by: Bryan Wu <cooloney@gmail.com>

Thanks,
-Bryan

>
>>  drivers/leds/Kconfig |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
>> index 0e41460..7226696 100644
>> --- a/drivers/leds/Kconfig
>> +++ b/drivers/leds/Kconfig
>> @@ -407,8 +407,8 @@ config LEDS_NS2
>>
>>  config LEDS_NETXBIG
>>       tristate "LED support for Big Network series LEDs"
>> -     depends on MACH_NET2BIG_V2 || MACH_NET5BIG_V2
>>       depends on LEDS_CLASS
>> +     depends on ARCH_KIRKWOOD
>>       default y
>>       help
>>         This option enable support for LEDs found on the LaCie 2Big
>> --
>> 1.7.10.4
>>
