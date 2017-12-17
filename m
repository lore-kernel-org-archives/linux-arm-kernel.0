From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Dec 2017 21:07:06 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171217204122.0a10a5e1@jawa>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
 <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
 <20171217204122.0a10a5e1@jawa>
Message-ID: <CAK8P3a09V1ZhhVCvdy27BiBCMM54zo4qyypgSDvrg2CdpneVmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 17, 2017 at 8:41 PM, Lukasz Majewski <lukma@denx.de> wrote:
>> >> We also need to think about upholding support in GCC for
>> >> ARMv4(t) for the foreseeable future if there is a big web of
>> >> random deeply embedded systems out there that will need
>> >> updates.
>> >
>> > But we should definitely preserve at least what we have.
>>
>> Plain ARMv4 (and earlier) support in gcc is already marked
>> 'deprecated' and will likely be gone in gcc-8 (it's still there as of
>> last week). ARMv4T is going to be around for a while, and you can
>> even keep building for ARMv4 using "-march=armv4t -marm" when linking
>> with 'ld --fix-v4bx'.
>
> I think that we shall start complaining on the gcc-devel mailing list
> now.
>
> I would be hard to wake up in 2 years time and realise that we don't
> have a modern compiler.

What distro or build system are you using? It would also be helpful
to test whether the -march=armv4t/--fix-v4bx workaround produces
working binaries for you, in that case you could report to the gcc
developers that the removal of armv4 can continue but that
the --fix-v4bx option in ld needs to stay around.

       Arnd
