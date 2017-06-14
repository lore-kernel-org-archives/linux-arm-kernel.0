From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Jun 2017 09:46:50 +0200
Subject: [PATCH] bus: SIMPLE_PM_BUS does not depend on ARCH_RENESAS
In-Reply-To: <20170613204841.GG19546@hector.attlocal.net>
References: <20170613130430.4272-1-robdclark@gmail.com>
 <20170613204841.GG19546@hector.attlocal.net>
Message-ID: <CAMuHMdWvwUFT-BbXpy4=vErb4dEW4dXMsH75Q768jaiJ7UoEKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Tue, Jun 13, 2017 at 10:48 PM, Andy Gross <andy.gross@linaro.org> wrote:
> On Tue, Jun 13, 2017 at 09:04:30AM -0400, Rob Clark wrote:
>> In fact, it is needed for PCI to work on msm8996 (and probably other
>> things).  No idea why it was depending on renesas but that doesn't make
>> any sense.  So drop the dependency.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>>  drivers/bus/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
>> index 0a52da4..b83c535 100644
>> --- a/drivers/bus/Kconfig
>> +++ b/drivers/bus/Kconfig
>> @@ -121,7 +121,6 @@ config QCOM_EBI2
>>  config SIMPLE_PM_BUS
>>       bool "Simple Power-Managed Bus Driver"
>>       depends on OF && PM
>> -     depends on ARCH_RENESAS || COMPILE_TEST
>
> Do you really want to drop COMPILE_TEST?

As dummies are available for all pm_*() and of_*() used by simple-pm-bus.c,
I think the COMPILE_TEST can be moved one line up, i.e.

    depends on (OF && PM) || COMPILE_TEST

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
