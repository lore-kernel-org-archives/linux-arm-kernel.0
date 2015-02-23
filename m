From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Feb 2015 12:11:05 -0700
Subject: [PATCH] ARM: bcm2835: Add header file for pinctrl constants
In-Reply-To: <5700696.0jJhSRhno5@wuerfel>
References: <1424624396-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <5700696.0jJhSRhno5@wuerfel>
Message-ID: <54EB7B49.8050706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2015 01:13 PM, Arnd Bergmann wrote:
> On Sunday 22 February 2015 16:59:56 Charles Keepax wrote:
>> +
>> +/* IRQ Flags */
>> +#define BCM2835_PIN_IRQ_RISING                         1
>> +#define BCM2835_PIN_IRQ_FALLING                                2
>> +#define BCM2835_PIN_IRQ_EDGE   (BCM2835_PIN_IRQ_RISING | \
>> +                                BCM2835_PIN_IRQ_FALLING)
>> +#define BCM2835_PIN_IRQ_LOW                            4
>> +#define BCM2835_PIN_IRQ_HIGH                           8
>
> Are these different from the standard definitions?
>
>> +/* Pin Function Settings */
>> +#define BCM2835_PIN_FUNC_GPIO_IN                       0
>> +#define BCM2835_PIN_FUNC_GPIO_OUT                      1
>> +#define BCM2835_PIN_FUNC_ALT5                          2
>> +#define BCM2835_PIN_FUNC_ALT4                          3
>> +#define BCM2835_PIN_FUNC_ALT0                          4
>> +#define BCM2835_PIN_FUNC_ALT1                          5
>> +#define BCM2835_PIN_FUNC_ALT2                          6
>> +#define BCM2835_PIN_FUNC_ALT3                          7
>
> Why are these required? They don't seem to be used by any driver,
> which leads me to suspect that they are just the hardware numbers.
>
> In that case, don't add any syntactical sugar like that and just
> use the hardware numbers directly.
>
> What's with the strange mapping of numbers anyway?

Especially given that the number->semantics meaning is a little 
non-linear it seems like using #defines/... to document what the numbers 
mean seems reasonable. It allows easily validating the DT files without 
having to go look up the meaning of the numbers in the documentation.
