From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 6 Nov 2013 10:13:26 +0100
Subject: [PATCH v2 2/2] ARM: at91: sama5d3/dt: add sama5d36ek dts files
In-Reply-To: <5279DC71.6020401@atmel.com>
References: <1383705071-7332-1-git-send-email-josh.wu@atmel.com>
 <1383705071-7332-3-git-send-email-josh.wu@atmel.com>
 <5279CCAB.9000303@gmail.com> <5279DC71.6020401@atmel.com>
Message-ID: <527A0836.5020200@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2013 07:06, Josh Wu :
> Hi, Dinh
>
> On 11/6/2013 12:59 PM, Dinh Nguyen wrote:
>> On 11/5/13 8:31 PM, Josh Wu wrote:
>>> Add .dts and .dtsi file to support sama5d36ek board.
>>> Also update the the comments for sama5d36 in sama5d3.dtsi.
>>>
>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>> ---
>>> v1 --> v2:
>>>     add a new sama5d36.dtsi file to include the peripheral dtsi file.
>>>
>>>    arch/arm/boot/dts/Makefile       |    1 +
>>>    arch/arm/boot/dts/sama5d3.dtsi   |    2 +-
>>>    arch/arm/boot/dts/sama5d36.dtsi  |   19 ++++++++++++++
>>>    arch/arm/boot/dts/sama5d36ek.dts |   53 ++++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 75 insertions(+), 1 deletion(-)
>>>    create mode 100644 arch/arm/boot/dts/sama5d36.dtsi
>>>    create mode 100644 arch/arm/boot/dts/sama5d36ek.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index e95af3f..ddbb049 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -40,6 +40,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d31ek.dtb
>>>    dtb-$(CONFIG_ARCH_AT91)	+= sama5d33ek.dtb
>>>    dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
>>>    dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
>>> +dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
>> Just curious...but just wondering why there are a separate
>> CONFIG_ARCH_AT91 for each board?
>> Why can't there be just a single CONFIG_ARCH_AT91 for all the boards?
>
> right. that seems consistent with other boards.
> So in v3 I will add one more patch to do this. Thanks.

No. Please do not change this.
It was modified in commit
ec6754a7b9e90a1eba7f3b2812003bb51d3dcf30
So if we have to come back to the former layout, we have to discuss it 
further.

Moreover this layout is easily readable, clear and easily expandable. So 
unless there is a consensus on moving to the other form, I would keep it 
like this.

Best regards,


>> Dinh
>>>
>>>    dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
>>>    dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb \
>>> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
>>> index 5cdaba4..23b7669 100644
>>> --- a/arch/arm/boot/dts/sama5d3.dtsi
>>> +++ b/arch/arm/boot/dts/sama5d3.dtsi
>>> @@ -1,6 +1,6 @@
>>>    /*
>>>     * sama5d3.dtsi - Device Tree Include file for SAMA5D3 family SoC
>>> - *                applies to SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35 SoC
>>> + *                applies to SAMA5D31, SAMA5D33, SAMA5D34, SAMA5D35, SAMA5D36 SoC
>>>     *
>>>     *  Copyright (C) 2013 Atmel,
>>>     *                2013 Ludovic Desroches <ludovic.desroches@atmel.com>
>>> diff --git a/arch/arm/boot/dts/sama5d36.dtsi b/arch/arm/boot/dts/sama5d36.dtsi
>>> new file mode 100644
>>> index 0000000..ec61c08
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/sama5d36.dtsi
>>> @@ -0,0 +1,19 @@
>>> +/*
>>> + * sama5d36.dtsi - Device Tree Include file for SAMA5D36 SoC
>>> + *
>>> + *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
>>> + *
>>> + * Licensed under GPLv2 or later.
>>> + */
>>> +#include "sama5d3.dtsi"
>>> +#include "sama5d3_can.dtsi"
>>> +#include "sama5d3_emac.dtsi"
>>> +#include "sama5d3_gmac.dtsi"
>>> +#include "sama5d3_lcd.dtsi"
>>> +#include "sama5d3_mci2.dtsi"
>>> +#include "sama5d3_tcb1.dtsi"
>>> +#include "sama5d3_uart.dtsi"
>>> +
>>> +/ {
>>> +	compatible = "atmel,samad36", "atmel,sama5d3", "atmel,sama5";
>>> +};
>>> diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
>>> new file mode 100644
>>> index 0000000..59576c6
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/sama5d36ek.dts
>>> @@ -0,0 +1,53 @@
>>> +/*
>>> + * sama5d36ek.dts - Device Tree file for SAMA5D36-EK board
>>> + *
>>> + *  Copyright (C) 2013 Atmel,
>>> + *                2013 Josh Wu <josh.wu@atmel.com>
>>> + *
>>> + * Licensed under GPLv2 or later.
>>> + */
>>> +/dts-v1/;
>>> +#include "sama5d36.dtsi"
>>> +#include "sama5d3xmb.dtsi"
>>> +#include "sama5d3xdm.dtsi"
>>> +
>>> +/ {
>>> +	model = "Atmel SAMA5D36-EK";
>>> +	compatible = "atmel,sama5d36ek", "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d36", "atmel,sama5d3", "atmel,sama5";
>>> +
>>> +	ahb {
>>> +		apb {
>>> +			spi0: spi at f0004000 {
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			ssc0: ssc at f0008000 {
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			can0: can at f000c000 {
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			i2c0: i2c at f0014000 {
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			i2c1: i2c at f0018000 {
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			macb0: ethernet at f0028000 {
>>> +				status = "okay";
>>> +			};
>>> +
>>> +			macb1: ethernet at f802c000 {
>>> +				status = "okay";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	sound {
>>> +		status = "okay";
>>> +	};
>>> +};
>
>


-- 
Nicolas Ferre
