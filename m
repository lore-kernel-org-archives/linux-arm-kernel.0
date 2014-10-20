From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Mon, 20 Oct 2014 15:27:24 +0800
Subject: [PATCH v2 5/5] tty/serial: Add earlycon support for Spreadtrum
 serial driver
In-Reply-To: <20141017130354.GC5587@leverpostej>
References: <1413539665-11484-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1413539665-11484-6-git-send-email-chunyan.zhang@spreadtrum.com>
 <20141017130354.GC5587@leverpostej>
Message-ID: <CAAfSe-sJxVZ46aQfGyOh+eTepiXwPhQPQCX-3yZ0Ew30n+oP+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-10-17 21:03 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> On Fri, Oct 17, 2014 at 10:54:25AM +0100, Chunyan Zhang wrote:
>> Add serial driver for spreadtrum sharkl platform with earlycon
>> support at first.
>>
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
>> ---
>>  drivers/tty/serial/Kconfig       |   24 ++++++++++++++
>>  drivers/tty/serial/Makefile      |    1 +
>>  drivers/tty/serial/sprd-serial.c |   64 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 89 insertions(+)
>>  create mode 100644 drivers/tty/serial/sprd-serial.c
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 26cec64..33b8f90 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -113,6 +113,30 @@ config SERIAL_SB1250_DUART_CONSOLE
>>
>>         If unsure, say Y.
>>
>> +config SERIAL_SPRD
>> +     tristate "Support for SPRD serial"
>> +     depends on ARM || ARM64
>> +     select SERIAL_CORE
>> +     help
>> +          This enables the driver for the Spreadtrum's serial.
>> +
>> +config SERIAL_SPRD_NR
>> +        int "Maximum number of sprd serial ports"
>> +        depends on SERIAL_SPRD
>> +        default "4"
>
> This is not used below.
>
Ok, I'll remove it in v3.

>> +
>> +config SERIAL_SPRD_CONSOLE
>> +        bool "SPRD UART console support"
>> +        depends on SERIAL_SPRD=y
>> +        select SERIAL_CORE_CONSOLE
>> +     select SERIAL_EARLYCON
>> +        help
>> +       Support for early debug console using Spreadtrum's serial. This enables
>> +       the console before standard serial driver is probed. This is enabled
>> +       with "earlycon=serial_sprd" on the kernel command line. The console is
>> +       enabled when early_param is processed.
>
> There only appears to be an earlycon driver, and not "standard serial
> driver".
>
> What happens after earlycon?
>
> Surely there should be a real driver to take ownership of the UART?
>
> As far as I can see it won't be possible to boot your platform to a
> prompt, because earlycon will have gone before that.
>
> Thanks,
> Mark.
>

We are planed to add standard serial driver after this patch-set is approved.
In the first patch we contribute to the upstream, I'd like to add
architecture related code of
Spreadtrum's Sharkl, and then we will add more functions about Sharkl3
SoC step by step.

I'm very glad to read your comments, if you have any suggestions, feel
free to tell us.

Thanks,
Chunyan
