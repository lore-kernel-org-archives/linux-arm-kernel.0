From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 Oct 2015 01:41:10 +0000
Subject: [PATCH 1/2] pinctrl: uniphier: enable UniPhier SoCs pinctrl
 drivers by default
In-Reply-To: <CACRpkdY4hs_7dE2KicDeUj7hvbKmHu3pcwQO3eshTtSmzH2PGA@mail.gmail.com>
References: <1445912911-1292-1-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdY4hs_7dE2KicDeUj7hvbKmHu3pcwQO3eshTtSmzH2PGA@mail.gmail.com>
Message-ID: <20151031014110.GA1991@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 02:33:34PM +0100, Linus Walleij wrote:
> On Tue, Oct 27, 2015 at 3:28 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> 
> > Add "default y" to the Kconfig rather than adding entries into
> > arch/arm/configs/multi_v7_defconfig.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> (...)
> > config PINCTRL_UNIPHIER_PH1_LD4
> >         tristate "UniPhier PH1-LD4 SoC pinctrl driver"
> > +       default y
> >         select PINCTRL_UNIPHIER_CORE
> 
> Why is it not default y if <PH1_LD4_SOC_THING>?
> 
> So it is only turned on if the corresponding SoC is selected?
> 
> Or don't you have symbols like that?
> 
> ARM SoC folks: can you ACK this patch indicating that this is the way
> you wanna handle this?

Most other will have a "default MACH_<foo>", but Uniphier lacks those Kconfig
symbols. Or even a def_bool for that platform such that it's not an option if
the platform is enabled. It makes no sense to enable a platform but not the
pinctrl on it, so that's a good way to do it.

I would honestly rather have those in the mach makefile, and make the drivers
select the right thing by default, than having to know exactly which drivers to
enable for a specific SoC.


-Olof
