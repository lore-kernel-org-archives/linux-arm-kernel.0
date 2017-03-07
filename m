From: j-keerthy@ti.com (Keerthy)
Date: Tue, 7 Mar 2017 12:43:36 +0530
Subject: [PATCH 0/7] thermal: ti-soc-thermal: Migrate slope/offset data to
 device tree
In-Reply-To: <20170306184215.GO20572@atomide.com>
References: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
 <20170306184215.GO20572@atomide.com>
Message-ID: <1c47d169-7962-2fe7-0635-570881e85e06@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 07 March 2017 12:12 AM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [170301 02:31]:
>> Currently the slope and offset values for calculating the
>> hot spot temperature of a particular thermal zone is part
>> of driver data. Pass them here instead and obtain the values
>> while of node parsing.
>>
>> Tested for the slope and constant values on DRA7-EVM.
>>
>> Keerthy (7):
>>   ARM: DRA7: Thermal: Add slope and offset values
>>   ARM: OMAP5: Thermal: Add slope and offset values
>>   ARM: OMAP443x: Thermal: Add slope and offset values
>>   ARM: OMAP4460: Thermal: Add slope and offset values
>>   thermal: ti-soc-thermal: Fetch slope and offset from DT
>>   thermal: ti-soc-thermal: Remove redundant constants
>>   thermal: ti-soc-thermal: Remove redundant code
>
> Are the dts changes safe for me to pick separately into
> omap-for-v4.12/dt?

Tony,

Seems like omap3 has no thermal_zone node defined in Device Tree.
It seems like it still uses driver data. I would need to add that as 
well. Can you confirm that? If yes i will send a new series with the 
omap3 device tree changes as well.

Thanks,
Keerthy

>
> Regards,
>
> Tony
>
