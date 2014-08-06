From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Wed, 06 Aug 2014 15:35:49 +0200
Subject: [PATCH V2 4/4] ARM: dts: i.MX53: Add PMU DT entry
In-Reply-To: <20140806105048.GF25953@arm.com>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144840.25462.57101.stgit@localhost> <20140806105048.GF25953@arm.com>
Message-ID: <53E22F35.4060503@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/14 12:50, Will Deacon wrote:
> On Tue, Aug 05, 2014 at 03:48:40PM +0100, Martin Fuzzey wrote:
>> Add device tree node for PMU on i.MX53
>>
>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
>> ---
>>   arch/arm/boot/dts/imx53.dtsi |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
>> index 6456a00..ab3afe0 100644
>> --- a/arch/arm/boot/dts/imx53.dtsi
>> +++ b/arch/arm/boot/dts/imx53.dtsi
>> @@ -101,6 +101,11 @@
>>   		interrupt-parent = <&tzic>;
>>   		ranges;
>>   
>> +		pmu {
>> +			compatible = "arm,cortex-a8-pmu";
>> +			interrupts = <77>;
>> +		};
> You're missing the new property.

Actually this was deliberate.

Since the property should only be used if booting in secure mode this 
generic dtsi file can't know if it is ok or not.
I presume a (probably out of tree) board / application dts file will add 
the property.

Maybe I should put a comment here about that though?

Martin
