From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 22 May 2013 18:02:51 +0200
Subject: [PATCH 3/5] ARM: dts: OMAP2+: convert DT files to use the new
 OMAP_GPIO macro
In-Reply-To: <519CE433.10903@wwwdotorg.org>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch>
 <1369232864-14460-4-git-send-email-florian.vaussard@epfl.ch>
 <519CE433.10903@wwwdotorg.org>
Message-ID: <519CEC2B.3040802@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stepen,

Thank you for your review,

On 05/22/2013 05:28 PM, Stephen Warren wrote:
> On 05/22/2013 08:27 AM, Florian Vaussard wrote:
>> Use OMAP_GPIO(), in conjunction with standard GPIO flags, to enhance the
>> readability of DT GPIOs.
>
>> diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> index e0ce823..e773a5e 100644
>> --- a/arch/arm/boot/dts/omap3-beagle-xm.dts
>> +++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
>> @@ -29,13 +29,13 @@
>>
>>   		heartbeat {
>>   			label = "beagleboard::usr0";
>> -			gpios = <&gpio5 22 0>; /* 150 -> D6 LED */
>> +			gpios = OMAP_GPIO(150, GPIO_ACTIVE_HIGH); /* 150 -> D6 LED */
>
> One of the advantages of cpp support for me is the ability to remove the
> redundant part of the command. In other words, perhaps remove the "150
> ->" since that information is part of the OMAP_GPIO() "call", leaving
> just /* D6 LED */. I might have expected "D6" to be the label too, thus
> removing any need for the comment.
>

I agree. I removed almost all the comments from the other files. For 
here, I would
leave /* D6 LED */ as you suggest.

Regards,

Florian
