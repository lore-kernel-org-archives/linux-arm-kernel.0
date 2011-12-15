From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Dec 2011 20:37:04 +0100
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
In-Reply-To: <77881664.jmuBXsRUXo@ws-stein>
References: <1323856877-18255-1-git-send-email-maxime.ripard@free-electrons.com>
 <1323856877-18255-2-git-send-email-maxime.ripard@free-electrons.com>
 <77881664.jmuBXsRUXo@ws-stein>
Message-ID: <4EEA4C60.4060409@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/2011 11:27, Alexander Stein wrote:
> On Wednesday 14 December 2011 11:01:15 Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  include/linux/platform_data/at91_adc.h |   23 +++++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>  create mode 100644 include/linux/platform_data/at91_adc.h
>>
>> diff --git a/include/linux/platform_data/at91_adc.h
>> b/include/linux/platform_data/at91_adc.h new file mode 100644
>> index 0000000..bad80b7
>> --- /dev/null
>> +++ b/include/linux/platform_data/at91_adc.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * Copyright (C) 2011 Free Electrons
>> + *
>> + * Licensed under the GPLv2 or later.
>> + *
>> + */
>> +
>> +#ifndef _AT91_ADC_H_
>> +#define _AT91_ADC_H_
>> +
>> +/**
>> + * struct at91_adc_data - platform data for ADC driver
>> + * @channels_use:	channels in use on the board as a bitmask
>> + * @vref:		Reference voltage for the ADC in millvolts
> 
> Nitpick, this should write millivolts, no?

Yes, of course :)

> 
>> + */
>> +struct at91_adc_data {
>> +	unsigned long	channels_used;
>> +	u16		vref;
>> +};
>> +
>> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
>> +
>> +#endif
> 
> Regards,
> Alexander


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
