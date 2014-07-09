From: a0393675@ti.com (Keerthy)
Date: Wed, 9 Jul 2014 15:02:51 +0530
Subject: [PATCH V2 2/2] ARM: dts: DRA7: Add node for RTC
In-Reply-To: <20140709091232.GJ28884@atomide.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
 <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
 <1404894932-26677-3-git-send-email-lokeshvutla@ti.com>
 <20140709091232.GJ28884@atomide.com>
Message-ID: <53BD0C43.1090002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wednesday 09 July 2014 02:42 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [140709 01:37]:
>> Add node for RTC.
>> And also making RTC regulator always-on, as RTC should be powered
>> always.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> [nm at ti.com: update with rtc crossbar number]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> This patch depends on the crossbar dt patch series by Sricharan:
>> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg106910.html
>>
>>   arch/arm/boot/dts/dra7-evm.dts |    1 +
>>   arch/arm/boot/dts/dra7.dtsi    |    9 +++++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
>> index 4adc280..bca6d4a 100644
>> --- a/arch/arm/boot/dts/dra7-evm.dts
>> +++ b/arch/arm/boot/dts/dra7-evm.dts
>> @@ -249,6 +249,7 @@
>>   					regulator-min-microvolt = <1050000>;
>>   					regulator-max-microvolt = <1050000>;
>>   					regulator-boot-on;
>> +					regulator-always-on;
>>   				};
>>   
> Is this regulator really always on?

This feeds on to RTC which is a free running clock. So i guess always on 
is justified no?

>
> Regards,
>
> Tony

Regards,
Keerthy
