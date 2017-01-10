From: peda@axentia.se (Peter Rosin)
Date: Tue, 10 Jan 2017 07:07:04 +0100
Subject: [PATCH v4 1/2] ARM: dts: at91: add devicetree for the Axentia
 TSE-850
In-Reply-To: <20170110053606.sqtnsbuawwa6s535@rob-hp-laptop>
References: <1483951529-11738-1-git-send-email-peda@axentia.se>
 <1483951529-11738-2-git-send-email-peda@axentia.se>
 <20170110053606.sqtnsbuawwa6s535@rob-hp-laptop>
Message-ID: <84c7297e-b536-456c-0b1d-26693f50ed44@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-10 06:36, Rob Herring wrote:
> On Mon, Jan 09, 2017 at 09:45:28AM +0100, Peter Rosin wrote:
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/arm/axentia.txt |  19 ++
>>  MAINTAINERS                                       |   8 +
>>  arch/arm/boot/dts/Makefile                        |   1 +
>>  arch/arm/boot/dts/at91-linea.dtsi                 |  53 +++++
>>  arch/arm/boot/dts/at91-tse850-3.dts               | 274 ++++++++++++++++++++++
>>  5 files changed, 355 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/axentia.txt
>>  create mode 100644 arch/arm/boot/dts/at91-linea.dtsi
>>  create mode 100644 arch/arm/boot/dts/at91-tse850-3.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/axentia.txt b/Documentation/devicetree/bindings/arm/axentia.txt
>> new file mode 100644
>> index 000000000000..ea3fb96ae465
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/axentia.txt
>> @@ -0,0 +1,19 @@
>> +Device tree bindings for Axentia ARM devices
>> +============================================
>> +
>> +Linea CPU module
>> +----------------
>> +
>> +Required root node properties:
>> +compatible = "axentia,linea",
>> +	     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
>> +and following the rules from atmel-at91.txt for a sama5d31 SoC.
>> +
>> +
>> +TSE-850 v3 board
>> +----------------
>> +
>> +Required root node properties:
>> +compatible = "axentia,tse850v3", "axentia,linea",
>> +	     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
>> +and following the rules from above for the axentia,linea CPU module.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 97b78cc5aa51..5c2ea6e9cd7f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2346,6 +2346,14 @@ S:	Maintained
>>  F:	Documentation/devicetree/bindings/sound/axentia,*
>>  F:	sound/soc/atmel/tse850-pcm5142.c
>>  
>> +AXENTIA ARM DEVICES
>> +M:	Peter Rosin <peda@axentia.se>
>> +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/arm/axentia.txt
>> +F:	arch/arm/boot/dts/at91-linea.dtsi
>> +F:	arch/arm/boot/dts/at91-tse850-3.dts
>> +
>>  AZ6007 DVB DRIVER
>>  M:	Mauro Carvalho Chehab <mchehab@s-opensource.com>
>>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 9a7375c388a8..7632849866de 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -48,6 +48,7 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>>  	at91-kizbox2.dtb \
>>  	at91-sama5d2_xplained.dtb \
>>  	at91-sama5d3_xplained.dtb \
>> +	at91-tse850-3.dtb \
>>  	sama5d31ek.dtb \
>>  	sama5d33ek.dtb \
>>  	sama5d34ek.dtb \
>> diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/at91-linea.dtsi
>> new file mode 100644
>> index 000000000000..20d982153a45
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/at91-linea.dtsi
>> @@ -0,0 +1,53 @@
>> +/*
>> + * at91-linea.dtsi - Device Tree Include file for the Axentia Linea Module.
>> + *
>> + * Copyright (C) 2017 Axentia Technologies AB
>> + *
>> + * Author: Peter Rosin <peda@axentia.se>
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include "sama5d31.dtsi"
>> +
>> +/ {
>> +	compatible = "axentia,linea",
>> +		     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
>> +
>> +	memory {
> 
> memory at 20000000 is preferred though if that causes bootloader problems 
> this is fine.

But then I get a dtb with one memory node from sama5d3.dtsi with
reg = <0x20000000 0x8000000> and one memory at 20000000 node with this
different reg content. Not pretty. Is that really preferred, even
if it works?

> Acked-by: Rob Herring <robh@kernel.org>

Thanks!

Cheers,
peda
