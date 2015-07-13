From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Jul 2015 18:41:18 +0200
Subject: Build regressions/improvements in v4.2-rc2
In-Reply-To: <CANLsYkx4_Z-9xbhW82XKnRs38xhofmx+FNUATcNG-3AjOc8fzQ@mail.gmail.com>
References: <1436779733-13678-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdX9pW3n+sD6zGFezZvDEcGvMmZobUDik4GYESh6iCgY5g@mail.gmail.com>
 <CANLsYkx4_Z-9xbhW82XKnRs38xhofmx+FNUATcNG-3AjOc8fzQ@mail.gmail.com>
Message-ID: <CAMuHMdXuG6-trLmNmNBjhrr2FRkcrCvKtXXUNS2dwxZavndU5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Mon, Jul 13, 2015 at 5:57 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On 13 July 2015 at 03:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Mon, Jul 13, 2015 at 11:28 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> JFYI, when comparing v4.2-rc2[1] to v4.2-rc1[3], the summaries are:
>>>   - build errors: +7/-5
>>
>>   + /home/kisskb/slave/src/fs/dax.c: error: implicit declaration of
>> function 'copy_user_page' [-Werror=implicit-function-declaration]:  =>
>> 267:2
>>
>> sh-randconfig (patch from Arnd updated and forwarder)
>>
>>   + error: coresight-etm-cp14.c: undefined reference to
>> `clk_add_alias':  => .init.text+0x12b0c)
>>
>> arm-randconfig
>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/head/9134/ (all 254 configs)
>>> [3] http://kisskb.ellerman.id.au/kisskb/head/9102/ (all 254 configs)
>
> Is it possible to have more information on this?  There is no
> reference to "clk_add_alias()" in coresight-etm-cp14.c and in the

That part I had noticed, too. And then I gave up...

> config provided in [3], CONFIG_CORESIGHT isn't defined.  I will try to
> reproduce this on my side once I have enough to work with.

[3] is a link to the previous set of build results.
You want to look at [1], where CONFIG_CORESIGHT=y:
http://kisskb.ellerman.id.au/kisskb/buildresult/12462798/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
