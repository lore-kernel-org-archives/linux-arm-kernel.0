From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 26 Oct 2016 13:56:29 +0200
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for obtaining
 mode pin state
In-Reply-To: <1477064730.2508.24.camel@pengutronix.de>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <1477064730.2508.24.camel@pengutronix.de>
Message-ID: <CAMuHMdUsuoLni1FUwCPXM2WrGpwKVR4UA85zujpbcwmdPMXpdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philip,

On Fri, Oct 21, 2016 at 5:45 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Freitag, den 21.10.2016, 15:17 +0200 schrieb Geert Uytterhoeven:
>>         Hi Philipp, Mike, Stephen, Simon, Magnus,
>>       (see questions *** below!)
>>
>> Currently the R-Car Clock Pulse Generator (CPG) drivers obtains the
>> state of the mode pins either by a call from the platform code, or
>> directly by using a hardcoded register access. This is a bit messy, and
>> creates a dependency between driver and platform code.
>>
>> This patch series converts the various Renesas R-Car clock drivers
>> and support code from reading the mode pin states using a hardcoded
>> register access to using a new minimalistic R-Car RST driver.

[...]

>>   - Philip: While this is a driver for a reset-controller, currently it
>>     doesn't provide any reset-controller functionality. Hence I added it
>>     to drivers/soc/renesas/. Is that OK for you?
>
> Absolutely, as long as the driver isn't even a reset controller
> provider, this is the right place.

Thank you!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
