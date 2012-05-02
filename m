From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 2 May 2012 10:03:20 +0800
Subject: [PATCH RESEND] ARM: pxa: hx4700: Initialize DS1WM clock_rate
In-Reply-To: <20120428173604.GC27792@n2100.arm.linux.org.uk>
References: <1335610789.79238.YahooMailClassic@web29018.mail.ird.yahoo.com>
 <20120428173604.GC27792@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZyonR=0ZswWkKNX4B7rXmqzJDkPcdNX6kJ7Y5_xNO2=WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 29, 2012 at 1:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> I don't know who's intending to take this, but I'd have thought Haojian
> would have...
>
> On Sat, Apr 28, 2012 at 11:59:49AM +0100, Paul Parsons wrote:
>> The asic3 driver now sets the DS1WM clock_rate from the newly added
>> asic3_platform_data clock_rate field.
>>
>> This patch initializes the asic3_platform_data clock_rate field on the
>> hx4700 platform.
>>
>> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
>> Cc: Philipp Zabel <philipp.zabel@gmail.com>
>> ---
>> ?arch/arm/mach-pxa/hx4700.c | ? ?1 +
>> ?1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
>> index 00a00a9..6bd692d 100644
>> --- a/arch/arm/mach-pxa/hx4700.c
>> +++ b/arch/arm/mach-pxa/hx4700.c
>> @@ -295,6 +295,7 @@ static struct asic3_platform_data asic3_platform_data = {
>> ? ? ? .gpio_config_num = ARRAY_SIZE(asic3_gpio_config),
>> ? ? ? .irq_base ? ? ? ?= IRQ_BOARD_START,
>> ? ? ? .gpio_base ? ? ? = HX4700_ASIC3_GPIO_BASE,
>> + ? ? .clock_rate ? ? ?= 4000000,
>> ? ? ? .leds ? ? ? ? ? ?= asic3_leds,
>> ?};
>>
>> --
>> 1.7.3.4
>>

Yes, I'll handle it. I required Paul to resend the patches since the
format of content is corrupted.

Paul,
Are you using copy & paste with html format to send patch? '=0A' is
CR, '=' is connecting character
between two lines. There's two much special characters, and I don't
want to handle them all.

I prefer you can use git-send-email to send patches. Or you can send
them as attachment.

Thanks
Haojian
