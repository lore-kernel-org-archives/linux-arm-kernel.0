From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2018 10:46:30 +0200
Subject: [PATCH] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <CAK8P3a21dCJuV7mmsVPboWXfxjEpBsiBh37nCk5WGRXWaMUHMg@mail.gmail.com>
References: <20180927073733.11580-1-linus.walleij@linaro.org>
 <20180927220439.GB20825@sirena.org.uk>
 <CAK8P3a21dCJuV7mmsVPboWXfxjEpBsiBh37nCk5WGRXWaMUHMg@mail.gmail.com>
Message-ID: <CACRpkdbZNUQ4iRXF_F6A7t-vd1jaZdWCw0eJK8WCJYqp-EqRNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 9:45 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 28, 2018 at 12:04 AM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Sep 27, 2018 at 09:37:33AM +0200, Linus Walleij wrote:
> >
> > > +F:   drivers/spi/spi-pl022.c
> >
> > The pl022 is actively used by *way* more than just the Arm reference
> > platforms, it's a really popular IP though the driver is fairly feature
> > complete at this point.  I'd like to at least see this split out as a
> > separate thing rather than lumped in so that people don't discount the
> > get_maintainers match as a false positive, though I'm totally fine with
> > you taking it over.
>
> The same logic probably applies to irq-vic.c, which is used on at least
> five other platforms.

I just saw that they were all orphaned so vaccumed them up from
the floor.

They are ARM PrimeCells that originate in these reference
designs: the VHDL code is on the CD that comes with Integrator,
Versatile etc, that is why this is appearing in more places,
companies bought the reference designs and took the VHDL
off the CD and started working on their SoC. So in some esoteric
sense they are closest associated with the reference designs.

So should I split out the SPI PL022 and VIC PL190 into their
own MAINTAINERS entries, simply?

Yours,
Linus Walleij
