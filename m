From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 1 Mar 2018 11:34:05 +0100
Subject: [PATCH] ARM: davinci: fix the GPIO lookup for omapl138-hawk
In-Reply-To: <2396d1a7-e4ef-95d7-3d38-309adcc3507e@ti.com>
References: <20180227121443.3191-1-brgl@bgdev.pl>
 <2396d1a7-e4ef-95d7-3d38-309adcc3507e@ti.com>
Message-ID: <CAMRc=MeFib2=vCj0-4zAXXJ9Cq8hDZFTxUQ3-FxHECd8xtzaYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-28 7:38 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 27 February 2018 05:44 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
>> mmc can correctly lookup the wp and cp gpios.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> index a3e78074be70..62eb7d668890 100644
>> --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
>> +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
>> @@ -127,8 +127,8 @@ static struct gpiod_lookup_table mmc_gpios_table = {
>>       .dev_id = "da830-mmc.0",
>>       .table = {
>>               /* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
>> -             GPIO_LOOKUP("davinci_gpio.1", 28, "cd", GPIO_ACTIVE_LOW),
>> -             GPIO_LOOKUP("davinci_gpio.1", 29, "wp", GPIO_ACTIVE_LOW),
>> +             GPIO_LOOKUP("davinci_gpio.0", 28, "cd", GPIO_ACTIVE_LOW),
>> +             GPIO_LOOKUP("davinci_gpio.0", 29, "wp", GPIO_ACTIVE_LOW),
>
> Hmm, shouldn't this just be "davinci_gpio" since we use .id = -1 in
> da8xx_gpio_device?
>

The gpio-davinci driver sets the gpiochip label to davinci_gpio.0 and
gpiolib sets the device name to chip's label.

> Also:
>
> Fixes: c69f43fb4f26 ("ARM: davinci: hawk: use gpio descriptor for mmc pins")
>
> Thanks,
> Sekhar

Sending v2.

Thanks,
Bartosz
