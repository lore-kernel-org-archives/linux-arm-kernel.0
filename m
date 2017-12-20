From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Dec 2017 13:48:56 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CAK8P3a3VJapioU32oBtA2GDmvXiHvz3K=W6BGx+u=Tvb1aDXsg@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
 <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
 <20171217204122.0a10a5e1@jawa>
 <CAK8P3a09V1ZhhVCvdy27BiBCMM54zo4qyypgSDvrg2CdpneVmg@mail.gmail.com>
 <20171217222856.2c5937a4@jawa>
 <CAK8P3a3VJapioU32oBtA2GDmvXiHvz3K=W6BGx+u=Tvb1aDXsg@mail.gmail.com>
Message-ID: <CACRpkda8xPuVHpBvX6_Ez+ztn4neVZ+=x=AEWmHJyZgww-1jHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 12:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Dec 17, 2017 at 10:28 PM, Lukasz Majewski <lukma@denx.de> wrote:
>>> On Sun, Dec 17, 2017 at 8:41 PM, Lukasz Majewski <lukma@denx.de>
>>> wrote:
>>> >> >> We also need to think about upholding support in GCC for
>>> >> >> ARMv4(t) for the foreseeable future if there is a big web of
>>> >> >> random deeply embedded systems out there that will need
>>> >> >> updates.
>>> >> >
>>> >> > But we should definitely preserve at least what we have.
>>> >>
>>> >> Plain ARMv4 (and earlier) support in gcc is already marked
>>> >> 'deprecated' and will likely be gone in gcc-8 (it's still there as
>>> >> of last week). ARMv4T is going to be around for a while, and you
>>> >> can even keep building for ARMv4 using "-march=armv4t -marm" when
>>> >> linking with 'ld --fix-v4bx'.
>>> >
>>> > I think that we shall start complaining on the gcc-devel mailing
>>> > list now.
>>> >
>>> > I would be hard to wake up in 2 years time and realise that we don't
>>> > have a modern compiler.
(...)
>>> It would also be helpful
>>> to test whether the -march=armv4t/--fix-v4bx workaround produces
>>> working binaries for you, in that case you could report to the gcc
>>> developers that the removal of armv4 can continue but that
>>> the --fix-v4bx option in ld needs to stay around.
>>
>> I may ask this issue on OE/Yocto mailing list as well....
>
> To clarify, the only  affected platforms are those based on either
> DEC/Intel StrongARM or Faraday FA526, i.e. EBSA-110,
> FootBridge, RPC, SA1100, Moxart and Gemini.

It's a bit unfortunate since there are users and active contributors to
these architectures, I think the OE community is being missed out
just because they "are not Debian". :/

Even NetWinder.org is still up and kicking.

Some of it may be nostalgia and platform-hugging with regards to
SA110 and SA1100 systems, I am certainly aware of such tendencies
in myself. And I understand if GCC drops support for old systems
that only have a bunch of elderly gentlemen running it for the fun of it.

What really worries me is if there are widely deployed SA110,
SA1100, FA526 or similar embedded systems using plain ARMv4
and doing regular kernel builds and userspaces for them, in
items with 20+ years support cycles.

With reports in the media about things like nuclear powerplants running
unsupported versions of Windows NT or 95, I want to make sure
that we're not creating a similar situation somewhere for deeply
embedded Linux. Sadly these users mostly seem to come out
of the shadows after-the-fact.

My own experiments with an upgraded Gemini platform are mostly
related to the fact that home routers using this ARMv4 SoC are still
being sold and deployed, using a v2.6 kernel (contributing to the
world of botnets I suppose). The hardware-accelerated gigabit ethernet
on these routers for the home make them still fully usable despite the
ARMv4 core, but securitywise they are a nightmare.

Yours,
Linus Walleij
