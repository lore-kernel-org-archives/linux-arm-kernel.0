From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 31 Jan 2013 12:24:46 +0100
Subject: [PATCH v7 0/6] watchdog: dt: add support for the timeout-sec dt
 property
In-Reply-To: <20130108153447.GC7360@game.jcrosoft.org>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
 <20130108153447.GC7360@game.jcrosoft.org>
Message-ID: <CAHkwnC-mLG9mehc8eRwEZGf1o8S7x16abtjoZLZTCmJ+UZYgMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 4:34 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 11:04 Tue 08 Jan     , Fabio Porcedda wrote:
>> Hi all,
>> this patchset add the timeout-sec property to the watchdog core,
>> to the at91sam9_wdt driver and on all framework enabled watchdog driver
>> with dt support.
>> The at91sam9_wdt is tested on evk-pr3,
>> the other drivers are compile tested only.
>>
>
> I'll prefer a macro to abstract the string in every driver

I know but Rob Herring dislikes that macro/function. I had to remove that part.

> except this fine by me

On Fri, Dec 21, 2012 at 12:32 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
>> Ping.
>>
>> The dependency is already merged.
>
> Will not be for this merge window. Will review next week.

Hi Wim,

Ping.

Best regards
Fabio Porcedda

> Best Regards,
> J.
>
>> Best regards
>> Fabio Porcedda
>>
>> changes:
>> v7:
>>   - rebase over v3.8-rc2
>>   - remove the patch already merged
>> v6:
>>   - remove patch for function of_get_timeout_sec as aked by Rob Herring
>>   - add Acked-by: Jason Cooper <jason@lakedaemon.net>
>>   - add Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> v5:
>>   - fix codestyle for compilance ti checkpatch.pl about
>>     "ERROR: do not initialise statics to 0 or NULL"
>>     for s3c2410_wdt.c:56 and at91sam9_wdt.c:63
>> v4:
>>   - add of_get_timeout_sec
>>   - add s3c2410_wdt driver
>>   - split driver patch
>>   - fixed watchdog_init_timeout handling of min_timeout and max_timeout
>> v3:
>>   - rename watchdog_probe_dt_timeout ->  watchdog_init_timeout
>>   - move the watchdog_init_timeout function from inline to watchdog_core.c
>>   - add timeout parameter handling code to watchdog_init_timeout
>>   - add timeout-sec property to the pnx4008-wdt driver
>>   - add two small commit for fixup and cleanup
>> v2:
>>   - change "timeout" to "timeout-sec" as asked by Jean-Christophe
>>   - at91sam9_wdt: use the new helper function
>>   - at91sam9_wdt: add bounds checking
>>   - watchdog.h: add bounds checking
>>
>> Fabio Porcedda (6):
>>   watchdog: core: dt: add support for the timeout-sec dt property
>>   watchdog: orion_wdt: add timeout-sec property binding
>>   watchdog: pnx4008: add timeout-sec property binding
>>   watchdog: s3c2410_wdt: add timeout-sec property binding
>>   watchdog: at91sam9_wdt: add timeout-sec property binding
>>   watchdog: orion_wdt: move the min_timeout initialization
>>
>>  .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 +++
>>  .../devicetree/bindings/watchdog/marvel.txt        |  5 +++
>>  .../devicetree/bindings/watchdog/pnx4008-wdt.txt   |  4 +++
>>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |  3 ++
>>  Documentation/watchdog/watchdog-kernel-api.txt     | 10 ++++++
>>  drivers/watchdog/Kconfig                           |  1 +
>>  drivers/watchdog/at91sam9_wdt.c                    | 16 ++++++++--
>>  drivers/watchdog/orion_wdt.c                       | 10 +++---
>>  drivers/watchdog/pnx4008_wdt.c                     |  7 ++--
>>  drivers/watchdog/s3c2410_wdt.c                     |  6 ++--
>>  drivers/watchdog/watchdog_core.c                   | 37 ++++++++++++++++++++++
>>  include/linux/watchdog.h                           |  3 ++
>>  12 files changed, 91 insertions(+), 15 deletions(-)
>>
>> --
>> 1.8.0.3
>>



--
Fabio Porcedda
