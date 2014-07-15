From: a0393675@ti.com (Keerthy)
Date: Tue, 15 Jul 2014 09:21:38 +0530
Subject: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
In-Reply-To: <53C3ED02.7020206@ti.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
 <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
 <1404894932-26677-3-git-send-email-lokeshvutla@ti.com>
 <20140709091232.GJ28884@atomide.com> <53BD0C43.1090002@ti.com>
 <20140709100914.GL28884@atomide.com> <53BD1AF8.2060609@ti.com>
 <20140709105055.GP28884@atomide.com> <53BD1FC3.6050500@ti.com>
 <20140709110051.GQ28884@atomide.com> <53BD2249.2080808@ti.com>
 <53C3ED02.7020206@ti.com>
Message-ID: <53C4A54A.1070500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 July 2014 08:15 PM, Lokesh Vutla wrote:
> Hi Tony,
> On Wednesday 09 July 2014 04:36 PM, Keerthy wrote:
>> On Wednesday 09 July 2014 04:30 PM, Tony Lindgren wrote:
>>> * Keerthy <a0393675@ti.com> [140709 03:59]:
>>>> On Wednesday 09 July 2014 04:20 PM, Tony Lindgren wrote:
>>>>> * Keerthy <a0393675@ti.com> [140709 03:39]:
>>>>>> On Wednesday 09 July 2014 03:39 PM, Tony Lindgren wrote:
>>>>>>> * Keerthy <a0393675@ti.com> [140709 02:36]:
>>>>>>>> On Wednesday 09 July 2014 02:42 PM, Tony Lindgren wrote:
>>>>>>>>> * Lokesh Vutla <lokeshvutla@ti.com> [140709 01:37]:
>>>>>>>>>> --- a/arch/arm/boot/dts/dra7-evm.dts
>>>>>>>>>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>>>>>>>>>> @@ -249,6 +249,7 @@
>>>>>>>>>>                        regulator-min-microvolt = <1050000>;
>>>>>>>>>>                        regulator-max-microvolt = <1050000>;
>>>>>>>>>>                        regulator-boot-on;
>>>>>>>>>> +                    regulator-always-on;
>>>>>>>>>>                    };
>>>>>>>>> Is this regulator really always on?
>>>>>>>> This feeds on to RTC which is a free running clock. So i guess always on is
>>>>>>>> justified no?
>>>>>>> Well the dts entries should describe the hardware. If the
>>>>>>> regulator can be enabled and disabled, we should not claim it's
>>>>>>> always on.
>>>>>>   From the PMIC perspective every regulator can be enabled and
>>>>>> disabled. From a Board perspective there are some which need
>>>>>> to be always on. For Ex: SMPS123 which feeds on to the MPU.
>>>>> Right, and we already have regulator-boot-on for those. Or are
>>>>> you seeing some issue with that?
>>>> regulator-boot-on describes that at boot a particular regulator is on.
>>>> It does not guarantee that it will be on for the rest of the time. The
>>>> regulator framework can go ahead and disable it if no one has requested
>>>> for it. In case of RTC we do not want that to happen.
>>> That's a bug in the RTC driver then. The driver should request a
>>> regulator if it's specified.
> In my experiments I observed that when RTC regulator is switched off and switched on, there is an abort while
> accessing RTC registers.
> After discussing with hardware team, it is confirmed that this LDO9 regulator powering RTC cannot be turned off when
> SoC is active and expected to be always on.
As confirmed by the PMIC hardware team this regulator should be an always-on
regulator.

Acked-by: Keerthy <j-keerthy@ti.com>
>
> Thanks and regards,
> Lokesh
>
>> Okay.
>>
>>> Regards,
>>>
>>> Tony
