From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 15 Feb 2012 22:00:42 +0100
Subject: [PATCH 2/4] arm/dts: OMAP4: Add SPI controller nodes
In-Reply-To: <20120215200240.GA25779@ponder.secretlab.ca>
References: <1329327457-2121-1-git-send-email-b-cousson@ti.com>
 <1329327457-2121-3-git-send-email-b-cousson@ti.com>
 <20120215200240.GA25779@ponder.secretlab.ca>
Message-ID: <4F3C1CFA.3050705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/15/2012 9:02 PM, Grant Likely wrote:
> On Wed, Feb 15, 2012 at 06:37:35PM +0100, Benoit Cousson wrote:
>> Add the 4 McSPI controller nodes present in an OMAP4 device.
>>
>> Remove SPI static device initialisation if DT is populated.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi  |   32 ++++++++++++++++++++++++++++++++
>>   arch/arm/mach-omap2/devices.c |    4 +++-
>>   2 files changed, 35 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 4b81f03..7fc0cbe 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -209,5 +209,37 @@
>>   			#size-cells =<0>;
>>   			ti,hwmods = "i2c4";
>>   		};
>> +
>> +		mcspi1: mcspi at 1 {
>> +			compatible = "ti,omap4-mcspi";
>> +			#address-cells =<1>;
>> +			#size-cells =<0>;
>> +			ti,hwmods = "mcspi1";
>> +			ti,spi-num-cs =<4>;
>
> No reg or interrupts properties?  And the @<num>  in the name must match the
> first entry in a reg property.  This looks wrong.

Well, it is done on purpose :-)

The idea being that since reg, irq and dma are still provided by hwmod 
data, I'd rather not populate this information here at all and thus not 
confuse people that will then think that these entries are valid and useful.

At some point, when I'll be able to migrate some of the hwmod data to 
DT, I will use the hwmod Python generator to generate the OMAP DTS and 
then populate the proper reg, interrupts and dma-requests.

It does not match with the DT convention yet, but this is to emphasis 
the temporary situation due to hwmod data still in use to build a device.

@<num> might be populated, but again the point was to be *consistent* in 
the overall inconsistency with regards to DT convention.

Does that make sense or not at all?

Regards,
Benoit
