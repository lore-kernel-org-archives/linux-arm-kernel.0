From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 22:57:30 +0000
Subject: [PATCH 1/5] ARM: sunxi: Increase the number of GPIOs available
In-Reply-To: <CACRpkdbZhS1APd6bFEnh9OLJEnNMgtFOCmW8vz1fVP3+yKy7LQ@mail.gmail.com>
References: <1359211016-24097-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359211016-24097-2-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdbZhS1APd6bFEnh9OLJEnNMgtFOCmW8vz1fVP3+yKy7LQ@mail.gmail.com>
Message-ID: <201301292257.30588.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Linus Walleij wrote:
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1632,7 +1632,7 @@ config ARCH_NR_GPIO
> >         default 355 if ARCH_U8500
> >         default 264 if MACH_H4700
> >         default 512 if SOC_OMAP5
> > -       default 288 if ARCH_VT8500
> > +       default 288 if ARCH_VT8500 || ARCH_SUNXI
> 
> Can I have an ACK from the ARM SoC maintainers on this?
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

for the change. Maybe you could also do a second patch on top that
sorts the lines by descending numbers and adds a comment? I think
for any multiplatform kernel, we have to pick the largest number
required by any of the enabled platforms.
