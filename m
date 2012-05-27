From: stigge@antcom.de (Roland Stigge)
Date: Sun, 27 May 2012 13:37:56 +0200
Subject: [PATCH RFC] serial/8250: Adjusting FIFO parameters for LPC32xx
In-Reply-To: <201205271023.16742.arnd@arndb.de>
References: <1338048678-23991-1-git-send-email-stigge@antcom.de>
 <201205270232.58253.arnd@arndb.de> <4FC1EEA7.2060109@antcom.de>
 <201205271023.16742.arnd@arndb.de>
Message-ID: <4FC21214.7060804@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/05/12 12:23, Arnd Bergmann wrote:
>> --- a/drivers/tty/serial/of_serial.c
>> +++ b/drivers/tty/serial/of_serial.c
>> @@ -179,6 +179,7 @@ static struct of_device_id __devinitdata of_platform_serial_table[] = {
>>         { .compatible = "ns16450",  .data = (void *)PORT_16450, },
>>         { .compatible = "ns16550a", .data = (void *)PORT_16550A, },
>>         { .compatible = "ns16550",  .data = (void *)PORT_16550, },
>> +       { .compatible = "ns16654",  .data = (void *)PORT_16654, },
>>         { .compatible = "ns16750",  .data = (void *)PORT_16750, },
>>         { .compatible = "ns16850",  .data = (void *)PORT_16850, },
>>         { .compatible = "nvidia,tegra20-uart", .data = (void *)PORT_TEGRA, },
>>
>> Wondering if it should rather be .compatible = "st16654"?
>> Will prepare a patch with adjustment of Documentation/.../of-serial.txt when
>> we agree on sth.
> 
> I think st16654 would be better than ns16654 here, yes.

OK, will provide a patch accordingly.

> Actually some of the other entries are wrong, too. The ns8250 entry should
> be i8250, and I guess the 16750 and 16850 were also not made by national.

But maybe we should keep the existing compatible strings because
existing boards/bootloaders are providing them already?

Roland
