From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Aug 2018 09:03:30 +0200
Subject: [PATCH 01/11] ARM/gpio: ep93xx: build standalone
In-Reply-To: <CAK8P3a2xgvS4Oxfupob1LcLP3CSfKrF3K-pu05S_3tB=pD3-mA@mail.gmail.com>
References: <20180822204111.9581-1-linus.walleij@linaro.org>
 <20180822204111.9581-2-linus.walleij@linaro.org>
 <CAK8P3a2xgvS4Oxfupob1LcLP3CSfKrF3K-pu05S_3tB=pD3-mA@mail.gmail.com>
Message-ID: <CACRpkdY26UVt5snsi5scM2y1odoByvmGu+Pd6FWRSxuH3Gr2Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2018 at 9:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Aug 22, 2018 at 10:41 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > As a preparation for multiplatform support, this ensures
> > that the ep93xx gpio driver can be built without any of
> > the platform specific header files. We pass the IRQ numbers
> > as a resource now, and use the virtual mmio base from the
> > already existing resource, rather than relying on the
> > hardwired virtual address from the header file.
> >
> > Some numbers are now hardcoded that came from macros
> > in the past, but for all I can tell, the driver already
> > relied on the specific values.
> >
> > Cc: arm at kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Arnd/other ARM SoC person:
> > Please provide an ACK for this patch so I can merge it
> > with the rest of the refactorings into the GPIO tree.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Did I send the patch to you, or did you find it in old archives?

You sent it at one point as we discussed modernizing EP93xx :)

I seem to finally start to get somewhere with that. Ground-up...

> Normally I'd assume that my authorship implies the Ack,
> but I guess it's ok to also explictly say that I'm ok with this
> going through your tree.

It's more of a handshake with ARM SoC so you folks know
this is going on.

Thanks!
Linus Walleij
