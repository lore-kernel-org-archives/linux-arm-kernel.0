From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Dec 2017 12:55:40 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171217222856.2c5937a4@jawa>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
 <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
 <20171217204122.0a10a5e1@jawa>
 <CAK8P3a09V1ZhhVCvdy27BiBCMM54zo4qyypgSDvrg2CdpneVmg@mail.gmail.com>
 <20171217222856.2c5937a4@jawa>
Message-ID: <CAK8P3a3VJapioU32oBtA2GDmvXiHvz3K=W6BGx+u=Tvb1aDXsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 10:28 PM, Lukasz Majewski <lukma@denx.de> wrote:
> Hi Arnd,
>
>> On Sun, Dec 17, 2017 at 8:41 PM, Lukasz Majewski <lukma@denx.de>
>> wrote:
>> >> >> We also need to think about upholding support in GCC for
>> >> >> ARMv4(t) for the foreseeable future if there is a big web of
>> >> >> random deeply embedded systems out there that will need
>> >> >> updates.
>> >> >
>> >> > But we should definitely preserve at least what we have.
>> >>
>> >> Plain ARMv4 (and earlier) support in gcc is already marked
>> >> 'deprecated' and will likely be gone in gcc-8 (it's still there as
>> >> of last week). ARMv4T is going to be around for a while, and you
>> >> can even keep building for ARMv4 using "-march=armv4t -marm" when
>> >> linking with 'ld --fix-v4bx'.
>> >
>> > I think that we shall start complaining on the gcc-devel mailing
>> > list now.
>> >
>> > I would be hard to wake up in 2 years time and realise that we don't
>> > have a modern compiler.
>>
>> What distro or build system are you using?
>
> I'm using OE with the "include conf/machine/include/tune-arm920t.inc"
>
> GCC 7.2 is working

Ah wait, this is still for ep93xx, which is always at least armv4t, right?
So it won't have a problem with the armv4 deprecation anyway, even
the older ep72xx/73xx were ARM720T based and don't have a problem.
I'm not entirely sure about their clps711x predecessors, which were some
earlier arm7 variant, but Linux doesn't support them any more anyway,
and the ARM710T would already be fine without --fix-v4bx.

>> It would also be helpful
>> to test whether the -march=armv4t/--fix-v4bx workaround produces
>> working binaries for you, in that case you could report to the gcc
>> developers that the removal of armv4 can continue but that
>> the --fix-v4bx option in ld needs to stay around.
>
> I may ask this issue on OE/Yocto mailing list as well....

To clarify, the only  affected platforms are those based on either
DEC/Intel StrongARM or Faraday FA526, i.e. EBSA-110,
FootBridge, RPC, SA1100, Moxart and Gemini.

       Arnd
