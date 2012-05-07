From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 May 2012 16:55:37 -0700
Subject: [PATCH V3 04/10] ARM: OMAP3: hwmod: rename the smartreflex entries
In-Reply-To: <87d36fzhkm.fsf@ti.com> (Kevin Hilman's message of "Mon, 07 May
 2012 16:39:53 -0700")
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <1335462041-4949-5-git-send-email-j-keerthy@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9B1AA2@DBDE01.ent.ti.com>
 <CAJ6a13ZSWSa_RpGB9NxtfyChUba9NGivGogpsfyk7oT9pNayjg@mail.gmail.com>
 <87d36fzhkm.fsf@ti.com>
Message-ID: <87r4uvwnpi.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> "J, KEERTHY" <j-keerthy@ti.com> writes:

[...]

>>>> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
>>>> index 2edd1e2..d859277 100644
>>>> --- a/arch/arm/mach-omap2/smartreflex.c
>>>> +++ b/arch/arm/mach-omap2/smartreflex.c
>>>> @@ -183,7 +183,7 @@ static void sr_set_regfields(struct omap_sr *sr)
>>>> ? ? ? ? ? ? ? sr->err_weight = OMAP3430_SR_ERRWEIGHT;
>>>> ? ? ? ? ? ? ? sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
>>>> ? ? ? ? ? ? ? sr->accum_data = OMAP3430_SR_ACCUMDATA;
>>>> - ? ? ? ? ? ? if (!(strcmp(sr->name, "sr1"))) {
>>>> + ? ? ? ? ? ? if (!(strcmp(sr->name, "smartreflex_mpu_iva"))) {
>>>
>>> What if voltage rail is different for mpu and iva? I have seen some devices
>>> supports SmartReflex have different voltage rails for mpu and iva.
>>>
>>
>> I get the point. OMAP3 iva and mpu have a common rail. OMAP4 onwards
>> even we have different rails for mpu and iva. I will enhance the checks here.
>
> Rather than enhancing the checks, this SoC specific data should probably
> just be made part of the SoC specific hwmod dev_attr.

That being said, this is an additional feature we can add after this
driver is moved.

I would like this series to concentrate on the cleanups necessary to
move to drivers/*, then additional features to support other SoCs can be
added on top.

Keerthy, please prepare a patch to generalize this to other SoCs by
using dev_attr for this SoC specific data.   We can add it after this
series is merged upstream.

Thanks,

Kevin
