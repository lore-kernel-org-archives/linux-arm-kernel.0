From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 1 Jun 2018 10:12:24 +0200
Subject: [PATCH v2 5/5] arm64: dts: renesas: r8a7795: add ccree binding
In-Reply-To: <CAOtvUMeBCH+23c3FDWncMwPPe5N=7yjRKzhyLmFXrYazgGbcJw@mail.gmail.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-6-git-send-email-gilad@benyossef.com>
 <20180529161936.prhp4oikzamr6u3n@verge.net.au>
 <CAOtvUMeBCH+23c3FDWncMwPPe5N=7yjRKzhyLmFXrYazgGbcJw@mail.gmail.com>
Message-ID: <CAMuHMdUX874g6pAz-Ze-yA3S+6aOhzUkfGN9wmQUhy-y0f7dMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gilad,

On Thu, May 31, 2018 at 1:55 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> On Tue, May 29, 2018 at 7:19 PM, Simon Horman <horms@verge.net.au> wrote:
>> On Thu, May 24, 2018 at 03:19:10PM +0100, Gilad Ben-Yossef wrote:
>>> Add bindings for CryptoCell instance in the SoC.
>>>
>>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>>
>> In so far as I can review the details of this (which is not much) this
>> looks fine to me. I am, however, a little unclear in when it should be
>> accepted.
>
> Since Herbert Xu ACKed the driver changes, I would say the only gating
> commit is Geert's CR clock patch.

These are queued for v4.19.

> If that one is in, than I would say this one should go in as well.

As the device node now has a power-domains property, the genpd code will
try to attach it to the CPG/MSSR PM Domain, which is a clock domain.
In the absence of the clock patch, the device's module clock cannot be
found, and dev_pm_domain_attach() and thus platform_drv_probe() will fail,
before calling the device driver's .probe() function.

So there is no longer a dependency on the clock patch, and the DT patch can
go in in parallel (although I prefer its subject to be changed
s/binding/device device/).

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
