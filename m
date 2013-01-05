From: olof@lixom.net (Olof Johansson)
Date: Sat, 5 Jan 2013 07:35:25 -0800
Subject: [PATCH 0/2] Add GPIO driver for Allwinner SoCs
In-Reply-To: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAOesGMiTZvLJ6cXwMFsFc6pBGoLUEkV+WMrDOqqCcs_TEnTtUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 4, 2013 at 8:45 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> This patch adds support for the GPIOs for the Allwinner SoCs supported so
> far.
>
> It comes on top of my previous pinctrl patchset, and has been tested on a
> A13-Olinuxino from Olimex.
>
> Thanks,
> Maxime
>
> Maxime Ripard (2):
>   ARM: sunxi: gpio: Add Allwinner SoCs GPIO drivers
>   ARM: sunxi: Add the GPIOs node to the device tree
>
>  .../devicetree/bindings/gpio/gpio-sunxi.txt        |   77 ++++++++++
>  arch/arm/boot/dts/sun5i-a13.dtsi                   |   51 +++++++
>  drivers/gpio/Kconfig                               |    6 +
>  drivers/gpio/Makefile                              |    1 +
>  drivers/gpio/gpio-sunxi.c                          |  150 ++++++++++++++++++++
>  drivers/pinctrl/pinctrl-sunxi.c                    |  106 ++++++++++++++
>  drivers/pinctrl/pinctrl-sunxi.h                    |    6 +-

I haven't looked closely at the patch yet, but this is a case where it
makes sense to merge the gpio/pinctrl patch through Linus/Grant's
tree, and merge the dtsi update through arm-soc -- while you need
both, nothing is broken by having just one or the other, so taking the
separate merge paths are fine.

Linus, Grant, sound ok to you?

-Olof
