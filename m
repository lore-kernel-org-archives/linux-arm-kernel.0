From: koct9i@gmail.com (Konstantin Khlebnikov)
Date: Sun, 6 Jul 2014 14:02:39 +0400
Subject: [PATCH] kconfig: store default ARCH in .config
In-Reply-To: <CAMuHMdWUpqz0W_znrrm2Qp+QjKExQ5Gcv0OsuA4gJa1Wvjv06A@mail.gmail.com>
References: <20140706080234.19520.96704.stgit@zurg>
 <1404637557.24853.12.camel@x220>
 <CAMuHMdWUpqz0W_znrrm2Qp+QjKExQ5Gcv0OsuA4gJa1Wvjv06A@mail.gmail.com>
Message-ID: <CALYGNiP3EREk4yDqnduuDhOsJLHFwZK4D1QGLd+u5edEk2JFOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 6, 2014 at 1:08 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Jul 6, 2014 at 11:05 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
>> On Sun, 2014-07-06 at 12:02 +0400, Konstantin Khlebnikov wrote:
>>> This patch makes cross-compilation configuration fully statefull.
>>> Default ARCH is stored in .config as CONFIG_DEFAULT_ARCH.
>>> After initial configuration specifying ARCH= is no longer required.
>>>
>>> To avoid recursion it is read directly from .config using scritps/config
>>> because include/config/auto.conf is not yet included at this point.
>>>
>>> Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
>>> ---
>>
>> It this needed because the Kconfig symbol ARCH is set only if ARCH is
>> set in the environment?
>>
>> Could the same result be had by saving CONFIG_ARCH in .config (I suppose
>> it actually already is) and then use its value on builds with
>
> No, currently it's not saved in .config, so I guess that's why this convoluted
> approach is needed.

Yep, kconfig neither reads nor writres symbols with option env=...

>
>> that .config unless ARCH is specified in the environment again? Ie,
>> change the "option env=[...]" semantics a bit, perhaps by special casing
>> CONFIG_ARCH.
>
> Indeed.

If it's saved in config value might be out of sync with actual environment:
ARCH != CONFIG_ARCH. So, behaviour becomes too complicated.

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
