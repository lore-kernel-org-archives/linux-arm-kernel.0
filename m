From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 11 Apr 2015 11:21:30 -0400
Subject: [PATCH] serial: earlycon requires console support
In-Reply-To: <19182495.QL5edbqjaN@wuerfel>
References: <5009638.HyplLv73fU@wuerfel> <5529241F.2040308@hurleysoftware.com>
 <19182495.QL5edbqjaN@wuerfel>
Message-ID: <55293BFA.1090201@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2015 11:00 AM, Arnd Bergmann wrote:
> On Saturday 11 April 2015 09:39:43 Peter Hurley wrote:
>> Hi Arnd,
>>
>> On 04/10/2015 06:01 PM, Arnd Bergmann wrote:
>>> A configuration that enables earlycon but not the core console
>>> code causes a link error:
>>>
>>> drivers/built-in.o: In function `setup_earlycon':
>>> drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'
>>>
>>> That error can be triggered by the newly added samsung earlycon support,
>>> which is missing a 'select' statement. This patch adds the 'select'
>>> to make serial-samsung behave like the other drivers.
>>
>> Since Kconfig has a separate option for enabling console on Samsung,
>> I'd rather move uart_parse_earlycon() and enclose it in
>>
>> #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_SERIAL_EARLYCON)
>> ...
>> #endif
>>
>> I'll send a fix for that right now.
>>
> 
> Hmm, maybe the 'select SERIAL_EARLYCON' should just be under SERIAL_SAMSUNG_CONSOLE
> then? Upon looking closer at the other drivers, that seems to be the common
> model, and I don't know what it means to have EARLYCON but no CORE_CONSOLE
> enabled.

Yeah, maybe that's better; will you send that?

Regards,
Peter Hurley
