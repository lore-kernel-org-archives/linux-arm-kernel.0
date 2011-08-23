From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Aug 2011 14:51:17 +0200
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25368@HQMAIL01.nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108161509.17157.arnd@arndb.de>
	<CACRpkdaVx=6AJ5DFjVN1ZYQ++hu9pT6WxD9n+pqmYVaCf1xawg@mail.gmail.com>
	<201108161637.16620.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA25368@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdY=nVQYnznTU7=_D0n1V1U_xOKH2y75-jKp7k7NzwH8Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 7:12 PM, Stephen Warren <swarren@nvidia.com> wrote:

> One issue here: There isn't always a single gpio/pinmux parent; as a
> concrete example, the ALSA/ASoC driver for Tegra+WM8903 uses GPIOs both
> from Tegra itself, and from the WM8903 audio codec.

The Ux500 have pinmuxing on the DB8500 and AB8500 - the latter
is a PMIC (&misc) connected to the DB8500 via I2C.

In the pincontrol subsystem I'm brewing, each of these will have
their own pin controller instance and their own struct gpio_chip as
well, so:

DB8500: pinctrl.0, gpio.0
AB8500: pinctrl.1, gpio.1

Each GPIO chip may have it's respective pin controller as parent
I guess, or they may simply be the same struct device * whatdoIknow.

I know this is vaporware, but does this reasoning hold also to
the Tegra+WM8903 combo?

Linus Walleij
