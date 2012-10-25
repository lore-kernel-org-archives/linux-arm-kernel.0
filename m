From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 09:00:52 +0200
Subject: [PATCH 1/5] ARM: Kirkwood: Allow use of pinctrl
In-Reply-To: <1351088724-11142-2-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
 <1351088724-11142-2-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdZq98m1hAzaL0O=9R=0tgbT7g5X6jh8F0Pw+NoPHtNwaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 4:25 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> We now have a pinctrl driver for arch-mvebu. It supports kirkwood out
> of the box. Allow ARCH_KIRKWOOD to select it, and make ARCH_KIRKWOOD
> select it. This then allows the convertion of board-*.c files away
> from MPP to pinctrl in DT, before they get moved over into mach-mvebu.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/Kconfig        |    2 ++
>  drivers/pinctrl/Kconfig |    2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 73067ef..160cd40 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -548,6 +548,8 @@ config ARCH_KIRKWOOD
>         select GENERIC_CLOCKEVENTS
>         select PCI
>         select PLAT_ORION_LEGACY
> +       select PINCTRL
> +       select PINCTRL_KIRKWOOD

Russell just spent the end of the release cycle sorting all of these
in alphanumeric order, so keep to that. (Move above
PLAT*)

Once they look OK I'd like to get ACKs from one of the ARM
SoC maintainers so I can merge this set through the
pinctrl tree.

Yours,
Linus Walleij
