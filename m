From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 17 Aug 2011 13:23:38 +0200
Subject: [RFC PATCH v2 00/13] arm/tegra: Initialize GPIO & pinmux from DT
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25368@HQMAIL01.nvidia.com>
References: <1313440100-17131-1-git-send-email-swarren@nvidia.com>
	<201108161637.16620.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04AEA25368@HQMAIL01.nvidia.com>
Message-ID: <201108171323.38441.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 August 2011, Stephen Warren wrote:
> One issue here: There isn't always a single gpio/pinmux parent; as a
> concrete example, the ALSA/ASoC driver for Tegra+WM8903 uses GPIOs both
> from Tegra itself, and from the WM8903 audio codec.
> 
> I could imagine the same being true in basically any case where one
> device uses N GPIOs (e.g. SD controller with power, change-detect,
> and read-only GPIOs; some could easily come from the SoC and some
> from a GPIO expander).
> 
> I'm not quite so sure that multiple parents would be useful for pinmux,
> but I wouldn't say that it was impossible...

Hmm, how common do you think the example is?

It it's just a very rare case, we can still special-case it by
introducing fake subdevices for the Tegra+WM8903 driver, each of
which has only one gpio-parent. This is ugly but keeps the special
case to the rare devices.

If we can expect more than a handful of these, we probably need
a better design for the binding, which will cause a burden for
all drivers.

	Arnd
