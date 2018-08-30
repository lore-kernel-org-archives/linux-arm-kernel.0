From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 30 Aug 2018 20:12:50 +0300
Subject: [PATCH 0/7] ARM32/64: DT overlay build support
In-Reply-To: <f9562e36-ef04-fb14-74a1-6a67feaa97a8@gmail.com>
References: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
 <f9562e36-ef04-fb14-74a1-6a67feaa97a8@gmail.com>
Message-ID: <183d979a-3849-7199-417f-3572b00dca5b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/08/18 21:40, Frank Rowand wrote:
> + Mark Rutland, just in case he is interested
> 
> On 08/28/18 05:32, Tero Kristo wrote:
>> Hi,
>>
>> This series introduces devicetree overlay building support for ARM
>> platforms. The .dtbo target is introduced globally, then makefile
>> changes for both arm32/64 for supporting the .dtbo target, changes
>> to support sub-dir makefile flags, and finally adding the DTC flags
>> override for TI platforms, as that is where we want to introduce
>> the DT overlay support initially.
>>
>> The ARM makefile changes for supporting DTS sub-makefiles don't look
>> too clean, but that was the only way I could figure out how to
>> get it done.
>>
>> -Tero
>>
>> --
>>
> 
> This series does three unrelated things:

Well, I was kind of trying to show the whole solution here but...

> (1) create a ti specific dts subdirectory arch/arm/boot/dts/ti/
> 
> (2) create a rule for creating a .dtbo from a .dtso
> 
> (3) add a dtc compile flag to add phandle symbol information to
>      all .dtb files created from arch/arm/boot/dts/ti/ and
>      arch/arm64/boot/dts/ti/
> 
> Please split the patches into three independent series so that
> each of the three concepts can be discussed separately. 

Ok will do that, hopefully tomorrow. Didn't manage to squeeze in time to 
do it today.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
