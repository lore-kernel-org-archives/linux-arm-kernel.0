From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 20 Nov 2013 16:59:49 +0100
Subject: [PATCH 1/9] ARM: at91/dt: add rm9200 spi0 chip select pins
 definitions
In-Reply-To: <20131120145609.GC14627@ns203013.ovh.net>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377687742-10618-1-git-send-email-b.brezillon@overkiz.com>
 <20131120145609.GC14627@ns203013.ovh.net>
Message-ID: <528CDC75.1010404@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2013 15:56, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:02 Wed 28 Aug     , Boris BREZILLON wrote:
>> Add spi0 cs pinctrl pins definitions.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   arch/arm/boot/dts/at91rm9200.dtsi |   20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
>> index f770655..69b76c7 100644
>> --- a/arch/arm/boot/dts/at91rm9200.dtsi
>> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
>> @@ -486,6 +486,26 @@
>>   							 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA1 periph A SPI0_MOSI pin */
>>   							 AT91_PIOA 2 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA2 periph A SPI0_SPCK pin */
>>   					};
>> +
>> +					pinctrl_spi0_cs0: spi0_cs0-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA3 periph A SPI0_NPCS0 pin */
>> +					};
>> +
>> +					pinctrl_spi0_cs1: spi0_cs1-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 4 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;	/* PA4 GPIO SPI0_NPCS1 pin */
>> +					};
>> +
>> +					pinctrl_spi0_cs2: spi0_cs2-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 5 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;	/* PA5 GPIO SPI0_NPCS2 pin */
>> +					};
>> +
>> +					pinctrl_spi0_cs3: spi0_cs3-0 {
>> +						atmel,pins =
>> +							<AT91_PIOA 6 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;	/* PA6 GPIO SPI0_NPCS3 pin */
>> +					};
> nack the pin are not multidrive there is only one master
Right, this is a mistake.

But the pins should be configured as OUTPUT with HIGH level
(see 
http://lxr.free-electrons.com/source/arch/arm/mach-at91/at91rm9200_devices.c#L589).

>
> Best Regards,
> J.
>>   				};
>>   
>>   				pioA: gpio at fffff400 {
>> -- 
>> 1.7.9.5
>>
