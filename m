From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 25 Jun 2014 18:33:00 -0300
Subject: [PATCH 09/10] ARM: sun4i: cubieboard: add an SPIdev device for
 testing
In-Reply-To: <20140625212238.GL19569@lukather>
References: <1402890635-12342-1-git-send-email-emilio@elopez.com.ar>
 <1402890635-12342-10-git-send-email-emilio@elopez.com.ar>
 <20140625212238.GL19569@lukather>
Message-ID: <53AB400C.6060007@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 25/06/14 18:22, Maxime Ripard escribi?:
> On Mon, Jun 16, 2014 at 12:50:34AM -0300, Emilio L?pez wrote:
>> ---
>>   arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 12 ++++++++++++
>>   arch/arm/boot/dts/sun4i-a10.dtsi           |  7 +++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> index 4684cbe..9b8d6b0 100644
>> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
>> @@ -61,6 +61,18 @@
>>   			status = "okay";
>>   		};
>>
>> +		spi0: spi at 01c05000 {
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&spi0_pins_a>;
>> +			status = "okay";
>> +
>> +			dac0: dh2228 at 2 {
>> +				compatible = "rohm,dh2228fv";
>
> Nope, this is not going to happen.
>
> It's not even what's connected on this bus.
>
> spidev isn't supposed to be described in DT, because it's just not
> hardware related at all.

Patches 9 and 10 are not intended to be merged, I am just sending them 
to facilitate testing. I suppose I could've been clearer on the cover 
letter, sorry.

Cheers,

Emilio
