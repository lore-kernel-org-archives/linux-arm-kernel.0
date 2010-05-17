From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Mon, 17 May 2010 15:59:41 +0200
Subject: [PATCH 05/15] ARM: S5PC100: Use common functions for gpiolib
	implementation
In-Reply-To: <003201caf5b2$2d641d00$882c5700$%kim@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
	<1273817946-29404-6-git-send-email-m.szyprowski@samsung.com>
	<003201caf5b2$2d641d00$882c5700$%kim@samsung.com>
Message-ID: <4BF14BCD.3050500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 17-05-10 13:14, Kukjin Kim schreef:
> Marek Szyprowski wrote:
>   
> <snip>
>> -
>>  static __init int s5pc1xx_gpiolib_init(void)
>>  {
>> -	struct s3c_gpio_chip *chips;
>> +	struct s3c_gpio_chip *chip;
>>  	int nr_chips;
>>
>> -		chips = s5pc100_gpio_chips;
>> -		nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
>> +	chip = s5pc100_gpio_chips;
>> +	nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
>> +
>> +	for (; nr_chips > 0; nr_chips--, chip++)
>> +		s5pc100_gpiolib_link(chip);
>>
>> -	s5pc1xx_gpiolib_add(chips, nr_chips, s5pc1xx_gpiolib_link);
>> +	samsung_gpiolib_add_4bit_chips(s5pc100_gpio_chips,
>> +				       ARRAY_SIZE(s5pc100_gpio_chips));
>>     
> nr_chips?
>   

You can't use nr_chips as it has been decremented to 0 in the for loop
above it.

-- 
Maurus Cuelenaere
