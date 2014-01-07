From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 7 Jan 2014 17:40:56 +0530
Subject: [PATCH] ARM: cache-l2x0: Parse properties from DT for PL310 cache
 controller
In-Reply-To: <3479510.EFrgCqQWpu@wuerfel>
References: <1389094888-24348-1-git-send-email-tushar.behera@linaro.org>
 <3479510.EFrgCqQWpu@wuerfel>
Message-ID: <CAHbNUh2Y5JPwAWojJE8Chd6fi5Hbk9c2+11FVBhOA-3Rgr5WpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2014 17:27, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 07 January 2014 17:11:28 Tushar Behera wrote:
>> Parsed auxiliary control properties for PL310 cache controller.
>>
>> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
>> ---
>> These properties are set for Exynos4 platform. If we can pass these properties
>> through device tree for Exynos4, then we can remove the hard-coded L2_AUX_VAL.
>
>
> The explanation would be good to have in the actual changeset

Ok, I will add these explanation to comment section.

> comment above the '---' line. Are all of them actually needed?
> You shouldn't havet o set the ones that are already turned on
> by the boot loader.

These are the extra options that we used to pass in the kernel. For
normal operation, I couldn't perceive any difference without these
properties. The only reason for adding these properties was to be in
sync with existing auxiliary control value.

>>
>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Documentation/devicetree/bindings/arm/l2cc.txt
>> index b513cb8..213546d 100644
>> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
>> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
>> @@ -44,6 +44,16 @@ Optional properties:
>>  - cache-id-part: cache id part number to be used if it is not present
>>    on hardware
>>  - wt-override: If present then L2 is forced to Write through mode
>> +- arm,early-write: If present then BRSEP mode (early write response) is enabled.
>> +- arm,data-prefetch: If present then data prefetching is enabled.
>> +- arm,instruction-prefetch: If present then instruction prefetching is enabled.
>> +- arm,ns-interrupt-access: If present then interrupt mask and interrupt clear
>> +  registers can be read or modified in both secure or non-secure accesses.
>> +- arm,ns-lockdown: If present then non-secure accesses can write to lockdown
>> +  register.
>> +- arm,share-override: If present then shared attribute is ignored internally.
>> +- arm,full-line-of-zero: If present then 'full line of write zero' behaviour is
>> +  enabled.
>
> Is it intentional that you have the "arm," prefix for the new ones, while
> it's not there for the existing ones? Should we drop it for consistency?
>
>         Arnd

No specific reasons for this. I was following "arm,data-latency"
format. We can drop the "arm," prefix.

Thanks for the review.

-- 
Tushar Behera
