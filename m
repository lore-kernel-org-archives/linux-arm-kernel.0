From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 6 Jan 2014 13:43:48 +0800
Subject: [PATCH v2] MAINTAINERS: ARM: SiRF: use regex patterns to involve
 all SiRF drivers
In-Reply-To: <20140103153908.GH10158@pengutronix.de>
References: <1388719453-12447-1-git-send-email-21cnbao@gmail.com>
 <20140103153908.GH10158@pengutronix.de>
Message-ID: <CAGsJ_4y1D1pn=dDKUcoevuRLZ3UKCnKjj1so3fBvZQ6vhSNnUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Fri, Jan 03, 2014 at 11:24:13AM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> instead of listing drivers one by one, use regex patterns to involve all
>> SiRF drivers directly.
>> this also adds sirf UART and watchdog drivers automatically from:
>> drivers/tty/serial/sirfsoc_uart.*
>> drivers/watchdog/sirfsoc_wdt.c
>>
>> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  -v2: use regex patterns according to Uwe's feedback
>>
>>  MAINTAINERS |    9 +--------
>>  1 files changed, 1 insertions(+), 8 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 21c038f..1b9e6a3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -850,14 +850,7 @@ F:       arch/arm/mach-prima2/
>>  F:   drivers/clk/clk-prima2.c
>>  F:   drivers/clocksource/timer-prima2.c
>>  F:   drivers/clocksource/timer-marco.c
>> -F:   drivers/dma/sirf-dma.c
>> -F:   drivers/i2c/busses/i2c-sirf.c
>> -F:   drivers/input/misc/sirfsoc-onkey.c
>> -F:   drivers/irqchip/irq-sirfsoc.c
>> -F:   drivers/mmc/host/sdhci-sirf.c
>> -F:   drivers/pinctrl/sirf/
>> -F:   drivers/rtc/rtc-sirfsoc.c
>> -F:   drivers/spi/spi-sirf.c
>> +N:   [^a-z]sirf
> I'm not sure what this [^a-z] is about, but I saw it used for tegra,
> too. Does it change the set of used files for you? I dropped it for
> efm32 because it doesn't.

no difference for me. i am just following the document:
"
N: Files and directories with regex patterns.
   N:   [^a-z]tegra     all files whose path contains the word tegra
"

>
> Best regards
> Uwe


-barry
