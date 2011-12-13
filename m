From: linux@solonet.org.ua (Denis Kuzmenko)
Date: Tue, 13 Dec 2011 23:21:13 +0200
Subject: [PATCH v3 resend2] s3c/s3c24xx: arm: leds: Make s3c24xx LEDS
 driver use gpiolib
In-Reply-To: <1323810417.3837.25.camel@joe2Laptop>
References: <4EE7B41C.5080006@solonet.org.ua>
 <1323810417.3837.25.camel@joe2Laptop>
Message-ID: <4EE7C1C9.8080000@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,
Thank you for review.

On 12/13/2011 11:06 PM, Joe Perches wrote:
> On Tue, 2011-12-13 at 22:22 +0200, Denis Kuzmenko wrote:
>> Make s3c24xx LEDS driver use gpiolib. Fix error disabling pull during probe.
> []
>> diff --git a/drivers/leds/leds-s3c24xx.c b/drivers/leds/leds-s3c24xx.c
> []
>> @@ -45,23 +45,35 @@ static void s3c24xx_led_set(struct led_classdev *led_cdev,
>> +	/*
>> +	 * ensure value is 0 or 1 to use it with bitwise XOR (^)
>> +	 * (only 100% brightness is supported)
>> +	 */
>> +	value = value ? 1 : 0;
> 
> Maybe value = !!value;

IMHO my variant is better readable.

>> +		/* no point in having a pull-up as we are always driving */
>> +		s3c_gpio_setpull(pdata->gpio, S3C_GPIO_PULL_NONE);
>> +		ret = gpio_direction_output(pdata->gpio,
>> +				!!(pdata->flags & S3C24XX_LEDF_ACTLOW));
> 
> akin to this use.

There is no so much space for implementation used before so I've used
shorter notation, again, for better readability.

-- 
Best regards, Denis Kuzmenko.
