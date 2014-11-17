From: j.uzycki@elproma.com.pl (=?UTF-8?B?SmFudXN6IFXFvHlja2k=?=)
Date: Mon, 17 Nov 2014 15:45:00 +0100
Subject: [PATCH] gpio: mxs: implement get_direction callback
In-Reply-To: <CACQ1gAjpXnnUPOj3paMGeB=NeQWR_7p6k8WPdxS9YzLakphBhw@mail.gmail.com>
References: <1416004026-9667-1-git-send-email-j.uzycki@elproma.com.pl>
 <20141114232601.GW27002@pengutronix.de> <5467A980.5090204@elproma.com.pl>
 <20141116214239.GX27002@pengutronix.de> <54693A51.5080907@elproma.com.pl>
 <CACQ1gAjpXnnUPOj3paMGeB=NeQWR_7p6k8WPdxS9YzLakphBhw@mail.gmail.com>
Message-ID: <546A09EC.8080809@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


W dniu 2014-11-17 o 10:26, Richard Genoud pisze:
> 2014-11-17 0:59 GMT+01:00 Janusz U?ycki <j.uzycki@elproma.com.pl>:
>> W dniu 2014-11-16 o 22:42, Uwe Kleine-K?nig pisze:
>>
>> Thanks Uwe. I fully agree with you.
>> a) was just a starter to your suggestion. My options were too conservative -
>> I just
>> wanted to avoid tests on hardware I don't have.
>> I don't understand why gpiod_get_direction() always requires the callback
>> and b) would be broken (I'm not so familiar with gpiolib) but I don't need
>> it now.
>>
>> So, it looks we can drop the gpio-mxs patch, yes?
>> And, I or Richard should submit a patch for
>> mctrl_gpio/atmel_serial/mxs-auart
>> to introduce the irq helper, yes?
> You're welcome to do it !
> At the time the mctrl_helpers were introduced, there was only one user
> (atmel_serial), so the line between specific code and factorizable
> code was not so clear.
> But clearly, the more we factorize, the better !
>
>> You wrote passing uart_port is enough. Argument "name" for request_irq() can
>> be
>> recovered from dev_name(dev) or dev_driver_string(dev)  where dev =
>> port_uart->dev.
> And, honestly, I'm not sure dev_name(dev) is a good name.
> Having something like dev_name(dev)_port_id_CTS may be better.
>

For names other than device's or driver's name I would need to allocate
string. Is it so important? You can simple check the interrupt and 
corresponding port:
cat /proc/interrupts
  50:          0  gpio-mxs  21  80072000.serial
  80:          0  gpio-mxs  18  8006c000.serial
  81:          0  gpio-mxs  19  8006c000.serial
  83:          0  gpio-mxs  21  8006c000.serial
  84:          0  gpio-mxs  22  8006c000.serial

best regards
Janusz

> Seems ok !
>
> Richard.
