From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 09 Jan 2017 11:32:35 -0800
Subject: [PATCH v2.1 1/4] ARM: dts: davinci: da850: VPIF: add node and
 muxing
In-Reply-To: <f3cdadf0-b0e9-9956-145a-9cc22024f6f9@ti.com> (Sekhar Nori's
 message of "Tue, 3 Jan 2017 11:05:00 +0530")
References: <20161207193137.27947-2-khilman@baylibre.com>
 <20161208001418.4469-1-khilman@baylibre.com>
 <f3cdadf0-b0e9-9956-145a-9cc22024f6f9@ti.com>
Message-ID: <m21swc81ws.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> Hi Kevin,
>
> On Thursday 08 December 2016 05:44 AM, Kevin Hilman wrote:
>> Add VPIF node an pins to da850 and enable on boards.  VPIF has two input
>> channels described using the standard DT ports and enpoints.
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> v2 -> v2.1: moved ports from SoC .dtsi to board .dts files.
>> 
>>  arch/arm/boot/dts/da850-evm.dts  | 20 ++++++++++++++++++++
>>  arch/arm/boot/dts/da850-lcdk.dts | 13 +++++++++++++
>>  arch/arm/boot/dts/da850.dtsi     | 27 ++++++++++++++++++++++++++-
>>  3 files changed, 59 insertions(+), 1 deletion(-)
>
> Can you split this patch to keep the SoC addition separate from board
> updates. Separating support addition for EVM and LCDK will be good also.

I don't understand why that matters, but OK.

>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index f79e1b91c680..5f0b40510b2b 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>
>> @@ -399,7 +410,21 @@
>>  				<&edma0 0 1>;
>>  			dma-names = "tx", "rx";
>>  		};
>> +
>> +		vpif: video at 217000 {
>> +			compatible = "ti,da850-vpif";
>> +			reg = <0x217000 0x1000>;
>> +			interrupts = <92>;
>> +			status = "disabled";
>> +
>> +			/* VPIF capture port */
>> +			port {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +			};
>> +		};
>
> Can you add this node just above mmc1? I am trying to keep the nodes
> sorted in the order of unit address instead of new ones getting added at
> the end. Unfortunately, it was not strictly enforced and we have many
> breakages. But lets add the new ones where they will eventually end up.

OK.

Kevin
