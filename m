From: nm@ti.com (Nishanth Menon)
Date: Mon, 10 Jan 2011 08:34:50 -0600
Subject: [PATCH v4 3/3] omap3: beaglexm: fix power on of DVI
In-Reply-To: <alpine.DEB.1.10.1101101445080.18906@esdhcp041196.research.nokia.com>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
	<1294441282-17986-4-git-send-email-nm@ti.com>
	<alpine.DEB.1.10.1101101445080.18906@esdhcp041196.research.nokia.com>
Message-ID: <4D2B190A.4020504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen had written, on 01/10/2011 06:51 AM, the following:
[..]
>> +    if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
>> +        gpio_request(gpio + 1, "nDVI_PWR_EN");
>> +        gpio_direction_output(gpio + 1, 0);
>> +        gpio_request(gpio + 2, "DVI_LDO_EN");
>> +        gpio_direction_output(gpio + 2, 1);
> 
> FYI, gpiolib provides gpio_request_one() and gpio_request_array() calls
> which make code simpler. I think any new code should use those _and_
> do proper error checking.
Thanks for pointing this out. Funny why it is in 
include/asm-generic/gpio.h instead of in include/linux/gpio.h 
considering it implemented in drivers/gpio/gpiolib.c :(

Am I right in understanding that you are mentioning about DVI gpios 
alone? in that case, the LDO gpio is used for other functions as well in 
addition to driving DVI. I suppose we dont want to loose that function 
because dvi pwr_en gpio failed.

-- 
Regards,
Nishanth Menon
