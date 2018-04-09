From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Apr 2018 15:29:32 +0200
Subject: [PATCH/RFC] soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies
 return failure
In-Reply-To: <2047337098.98106.1523186884813@email.1und1.de>
References: <1523178315-30562-1-git-send-email-geert@linux-m68k.org>
 <2047337098.98106.1523186884813@email.1und1.de>
Message-ID: <CAMuHMdWua5swcrNsvB5pbiMpuSyHSSoQhYSaqeq0ctP2csPtTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Sun, Apr 8, 2018 at 1:28 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> hat am 8. April 2018 um 11:05 geschrieben:
>> If CONFIG_RASPBERRYPI_FIRMWARE=n:
>>
>>     drivers/gpio/gpio-raspberrypi-exp.c: In function ?rpi_exp_gpio_get_polarity?:
>>     drivers/gpio/gpio-raspberrypi-exp.c:71: warning: ?get.polarity? is used uninitialized in this function
>>     drivers/gpio/gpio-raspberrypi-exp.c: In function ?rpi_exp_gpio_get_direction?:
>>     drivers/gpio/gpio-raspberrypi-exp.c:150: warning: ?get.direction? is used uninitialized in this function
>>
>> The dummy firmware interface functions return 0, which means success,
>> causing subsequent code to make use of the never initialized output
>> parameter.
>
> i think this is more theoritical, because we need to get rpi_firmware first and in this case it's NULL.

Sure, I just want to get rid of the ugly warnings when compile-testing.
Most dummy functions for other subsystems return error codes.

>> Fix this by making the dummy functions return an error code (-ENOSYS)
>> instead.
>
> Anyway i'm okay with the change.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
