From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 Jan 2015 09:38:22 +0100
Subject: [PATCH 4/4] ARM: mvebu: add Device Tree description of RTC on
 Armada 38x
In-Reply-To: <874mrui8r3.fsf@natisbad.org>
References: <1420817565-28800-1-git-send-email-gregory.clement@free-electrons.com>	<1420817565-28800-5-git-send-email-gregory.clement@free-electrons.com>
 <874mrui8r3.fsf@natisbad.org>
Message-ID: <54B62AFE.1030909@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On 14/01/2015 00:03, Arnaud Ebalard wrote:
> Hi Gregory,
> 
> Gregory CLEMENT <gregory.clement@free-electrons.com> writes:
> 
>> The Marvell Armada 38x SoCs contains an RTC which differs from the RTC
>> used in the other mvebu SoCs until now. This commit adds the Device
>> Tree description of this interface at the SoC level.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/armada-38x.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
>> index 04fe80d101f8..22909add8889 100644
>> --- a/arch/arm/boot/dts/armada-38x.dtsi
>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
>> @@ -466,6 +466,12 @@
>>  				clocks = <&gateclk 4>;
>>  			};
>>  
>> +			rtc at 184a8 {
>> +				compatible = "marvell,armada-380-rtc";
>> +				reg = <0xa3800 0x20>, <0x184a0 0x0c>;
>> +				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
> 
> Out of curiosity, why not naming the node rtc at a3800? Main argument:
> least expectation principle when reading the .dtsi and expecting
> increasing addresses. Or did I miss sth else?

It was a mistake, I should have used the 0xa3800 offset to name it because
most of the RTC registers are located here.


Thanks,

Gregory

> 
> 
>>  			sata at a8000 {
>>  				compatible = "marvell,armada-380-ahci";
>>  				reg = <0xa8000 0x2000>;


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
