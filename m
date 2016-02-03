From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 03 Feb 2016 17:36:01 +0100
Subject: [PATCH 01/10] serial: mvebu-uart: initial support for Armada-3700
 serial port
In-Reply-To: <5687888.WDl8xbENFR@wuerfel> (Arnd Bergmann's message of "Tue, 02
 Feb 2016 22:07:17 +0100")
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-2-git-send-email-gregory.clement@free-electrons.com>
 <5687888.WDl8xbENFR@wuerfel>
Message-ID: <87mvrh4uq6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mar., f?vr. 02 2016, Arnd Bergmann <arnd@arndb.de> wrote:

> On Tuesday 02 February 2016 19:07:39 Gregory CLEMENT wrote:
>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 39721ec4f415..b291f934d51b 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1606,6 +1606,28 @@ config SERIAL_STM32_CONSOLE
>>  	depends on SERIAL_STM32=y
>>  	select SERIAL_CORE_CONSOLE
>>  
>> +config SERIAL_MVEBU_UART
>> +	bool "Marvell EBU serial port support"
>
> Could this be a loadable module?

I don't see any reason to not being able to use it as a module. But I
didn't test it because currently te serial port is the only way ro
cimmunicate with the board.

>
>> +config SERIAL_MVEBU_CONSOLE
>> +	bool "Console on Marvell EBU serial port"
>> +	depends on SERIAL_MVEBU_UART
>
> If yes, this would become 
>
> 	depends on SERIAL_MVEBU_UART=y

OK, let's try to enable it.

Thanks,

Gregory

>
> 	Arnd
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
