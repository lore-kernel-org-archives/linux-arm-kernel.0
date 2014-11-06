From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Nov 2014 12:27:42 +0100
Subject: [PATCH] leds: leds-gpio: Convert gpio_blink_set() to use GPIO
 descriptors
In-Reply-To: <20141106112244.GM1618@lahna.fi.intel.com>
References: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
 <545843B1.3020101@nvidia.com> <2455157.3p7mHhT8im@vostro.rjw.lan>
 <CAMuHMdXn9W2S7N+YGfjDxQozMtRZCVdTzzdDps6YfOv2FqVBmw@mail.gmail.com>
 <20141106103033.GK1618@lahna.fi.intel.com>
 <CAMuHMdWtcZcpW=r60s9auENZxChiLwr14R0p_soKr7C3yGYOMQ@mail.gmail.com>
 <20141106105855.GL1618@lahna.fi.intel.com>
 <CAMuHMdUroLo5SdXrTu+etiW+TwHAWV-Qn9UsVnud+BJ7q6nXjw@mail.gmail.com>
 <20141106112244.GM1618@lahna.fi.intel.com>
Message-ID: <CAMuHMdVA=L22R=gDJBHcgGbD5tsTOPpVZHaxeLsaB+mXhQswVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 6, 2014 at 12:22 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Nov 06, 2014 at 12:12:04PM +0100, Geert Uytterhoeven wrote:
>> On Thu, Nov 6, 2014 at 11:58 AM, Mika Westerberg
>> <mika.westerberg@linux.intel.com> wrote:
>> > On Thu, Nov 06, 2014 at 11:32:19AM +0100, Geert Uytterhoeven wrote:
>> >> On Thu, Nov 6, 2014 at 11:30 AM, Mika Westerberg
>> >> <mika.westerberg@linux.intel.com> wrote:
>> >> >> "leds: leds-gpio: Add support for GPIO descriptors" broke leds-gpio on
>> >> >> non-DT platforms for me:
>> >> >>
>> >> >>     gpiod_direction_output: invalid GPIO
>> >> >>     leds-gpio: probe of leds-gpio failed with error -22
>> >> >>
>> >> >> (desc is NULL in gpiod_direction_output()).

>>     leds-gpio leds-gpio: GPIO 102, ret: 0
>>     leds-gpio leds-gpio: GPIOD: c050e970
>>
>> So led_dat is non-NULL. But it's overwritten by NULL later:
>>
>>     led_dat->gpiod = template->gpiod;
>
> Ah, that's it. Nice catch!
>
>> Whitespace damaged fix below, to fold into the original.
>> If you prefer a proper separate patch, let me know.
>
> It is up to Rafael. I think he wants to stabilize this branch so in that
> case separate patch on top would work better.

I've already sent a patch, as I have to publish the fix in my git tree anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
