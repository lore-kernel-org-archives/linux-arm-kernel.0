From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 20 Nov 2013 17:31:34 +0100
Subject: [PATCH 8/9] ARM: at91/dt: add new at91rm9200ek_mmc board
In-Reply-To: <20131120150255.GH14627@ns203013.ovh.net>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377693456-11133-1-git-send-email-b.brezillon@overkiz.com>
 <20131120150255.GH14627@ns203013.ovh.net>
Message-ID: <528CE3E6.1040802@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2013 16:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:37 Wed 28 Aug     , Boris BREZILLON wrote:
>> Add a new at91rm9200ek_mmc board (based on at91rm9200ek board) which enables
>> mmc0/slot0.
> no for multiple dts
>
> this need to handle at user space level

You mean, by controlling the regulator using the sysfs interface, or by 
loading
only the appropriate driver ?

What if both drivers are loaded (or not compiled as modules) ?
This will lead to one device being unusable (and maybe even worst)...

Please explain what you had in mind ?

>
> Best Regards,
> J.
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   arch/arm/boot/dts/at91rm9200ek_mmc.dts |   23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/at91rm9200ek_mmc.dts
>>
>> diff --git a/arch/arm/boot/dts/at91rm9200ek_mmc.dts b/arch/arm/boot/dts/at91rm9200ek_mmc.dts
>> new file mode 100644
>> index 0000000..c87a861
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/at91rm9200ek_mmc.dts
>> @@ -0,0 +1,23 @@
>> +/*
>> + * at91rm9200ek.dts - Device Tree file for Atmel AT91RM9200 evaluation kit with
>> + *                    an MMC slot
>> + *
>> + *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
>> + *
>> + * Licensed under GPLv2 only
>> + */
>> +/dts-v1/;
>> +#include "at91rm9200ek.dts"
>> +
>> +/ {
>> +	model = "Atmel AT91RM9200 evaluation kit with MMC slot";
>> +	compatible = "atmel,at91rm9200ek-mmc", "atmel,at91rm9200ek", "atmel,at91rm9200";
>> +
>> +	ahb {
>> +		apb {
>> +			mmc0: mmc at fffb4000 {
>> +				status = "okay";
>> +			};
>> +		};
>> +	};
>> +};
>> -- 
>> 1.7.9.5
>>
