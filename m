From: robherring2@gmail.com (Rob Herring)
Date: Tue, 14 Feb 2012 07:24:39 -0600
Subject: [PATCH 07/15] ARM: at91: clean-up mach/io.h
In-Reply-To: <4F3A2797.7000402@atmel.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-8-git-send-email-robherring2@gmail.com>
 <4F3A2797.7000402@atmel.com>
Message-ID: <4F3A6097.2030606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2012 03:21 AM, Nicolas Ferre wrote:
> On 02/13/2012 10:43 PM, Rob Herring :
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Move most of io.h into at91_io.h and update includes.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  arch/arm/mach-at91/at91cap9.c                     |    1 +
>>  arch/arm/mach-at91/at91cap9_devices.c             |    1 +
> 
> Please do not touch the "*cap9*" files anymore: They are scheduled for
> removal for 3.4 kernel:
> Documentation/feature-removal-schedule.txt

Okay.

> 
>>  arch/arm/mach-at91/at91rm9200.c                   |    1 +
>>  arch/arm/mach-at91/at91rm9200_devices.c           |    1 +
>>  arch/arm/mach-at91/at91rm9200_time.c              |    1 +
>>  arch/arm/mach-at91/at91sam9260.c                  |    1 +
>>  arch/arm/mach-at91/at91sam9260_devices.c          |    1 +
>>  arch/arm/mach-at91/at91sam9261.c                  |    1 +
>>  arch/arm/mach-at91/at91sam9261_devices.c          |    1 +
>>  arch/arm/mach-at91/at91sam9263.c                  |    1 +
>>  arch/arm/mach-at91/at91sam9263_devices.c          |    1 +
>>  arch/arm/mach-at91/at91sam9g45.c                  |    1 +
>>  arch/arm/mach-at91/at91sam9g45_devices.c          |    1 +
>>  arch/arm/mach-at91/at91sam9rl.c                   |    1 +
>>  arch/arm/mach-at91/at91sam9rl_devices.c           |    1 +
>>  arch/arm/mach-at91/at91x40.c                      |    1 +
>>  arch/arm/mach-at91/at91x40_time.c                 |    1 +
>>  arch/arm/mach-at91/board-cap9adk.c                |    1 +
>>  arch/arm/mach-at91/board-cpu9krea.c               |    1 +
>>  arch/arm/mach-at91/board-eco920.c                 |    1 +
>>  arch/arm/mach-at91/board-yl-9200.c                |    1 +
>>  arch/arm/mach-at91/clock.c                        |    1 +
>>  arch/arm/mach-at91/include/mach/at91_io.h         |   44 +++++++++++++++++++++
>>  arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h |    2 +
>>  arch/arm/mach-at91/include/mach/at91sam9_sdramc.h |    2 +
>>  arch/arm/mach-at91/include/mach/uncompress.h      |    1 +
>>  arch/arm/mach-at91/pm.c                           |    1 +
>>  arch/arm/mach-at91/pm.h                           |    2 +
>>  arch/arm/mach-at91/setup.c                        |    1 +
>>  drivers/pcmcia/at91_cf.c                          |    1 +
>>  drivers/rtc/rtc-at91sam9.c                        |    2 +-
>>  drivers/usb/gadget/at91_udc.c                     |    1 +
>>  drivers/watchdog/at91rm9200_wdt.c                 |    1 +
>>  drivers/watchdog/at91sam9_wdt.c                   |    1 +
>>  34 files changed, 80 insertions(+), 1 deletions(-)
>>  create mode 100644 arch/arm/mach-at91/include/mach/at91_io.h
>>

snip

>> diff --git a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
>> index e2f8da8..0427212 100644
>> --- a/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
>> +++ b/arch/arm/mach-at91/include/mach/at91sam9_ddrsdr.h
>> @@ -12,6 +12,8 @@
>>  #ifndef AT91SAM9_DDRSDR_H
>>  #define AT91SAM9_DDRSDR_H
>>  
>> +#include <mach/at91_io.h>
> 
> Do we need this include in header files?

Yes, for at91_sys_write/read used at the bottom.

Rob
