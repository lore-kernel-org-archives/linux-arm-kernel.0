From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 14 Jul 2014 20:32:29 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <16507628.c6raaN50oI@wuerfel>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <4494372.fAWcxQ0qku@wuerfel> <53C402C4.5090908@metafoo.de>
 <16507628.c6raaN50oI@wuerfel>
Message-ID: <53C4223D.6070902@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2014 08:23 PM, Arnd Bergmann wrote:
> On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:
>> On 07/14/2014 05:46 PM, Arnd Bergmann wrote:
>> [...]
>>>>> +static struct gpiod_lookup_table smartq_audio_gpios = {
>>>>> +   .dev_id = "smartq-audio",
>>>>> +   .table = {
>>>>> +           GPIO_LOOKUP("GPL", 12, "headphone detect", 0),
>>>>> +           GPIO_LOOKUP("GPK", 12, "amplifiers shutdown", GPIO_ACTIVE_HIGH),
>>>>
>>>> There is no such thing as GPIO_ACTIVE_HIGH, just 0 for flags.
>>>
>>> The original driver does gpio_direction_output(..., 1);
>>>
>>> For some reason I earlier concluded that this was what the '1' would need
>>> to get converted to. Are you sure '0' is correct then?
>>>
>>
>> Yes. But now that you say it the gpiod_direction_output() call is missing
>> from this patch.
>
> I'm lost now. The GPIO_ACTIVE_HIGH I added comes from Documentation/gpio/board.txt
> and as Linus Walleij explained to me the other day, the lookup is supposed
> to replace devm_gpio_request_one(), which in turn replaced both the
> gpio_request and the gpio_direction_output(). Do I need to put the
> gpiod_direction_output() back or is there another interface for that when
> registering the board gpios?

Hm, ok looks like there is a GPIO_ACTIVE_HIGH now, but its value 0. But it does 
not change the direction or set the initial output value. But maybe it is planed.

- Lars
