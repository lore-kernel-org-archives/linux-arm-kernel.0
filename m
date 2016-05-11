From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 11 May 2016 11:52:00 +0200
Subject: [PATCH 0/6] Enable ethernet support on Amlogic meson8b /
 Hardkernel ODROID-C1
In-Reply-To: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
 ("Alexander =?utf-8?Q?M=C3=BCller=22's?= message of "Tue, 10 May 2016
 22:08:34 +0200")
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
Message-ID: <m2eg989b27.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander M?ller <serveralex@gmail.com> writes:

> This patch series fixes a glitch in the pinctrl driver, adds clock gates
> support and configures ethernet support via stmmac.
>
> The previously sent patch "pinctrl: meson: Fix eth_tx_en bit index" is
> also included in this patch series.

Tested-by: Kevin Hilman <khilman@baylibre.com>

I tested ethernet support on my odroidc1 with an NFS root and things are
working well.

Alexander, could you separate out the clock patches and (re)send them
making sure to copy the linux-clk list so the clock maintainers are sure
to see them?  Thanks.

Kevin

>
> Alexander M?ller (6):
>   pinctrl: meson: Fix eth_tx_en bit index
>   ARM: DTS: Amlogic: Add ethernet pins
>   ARM: clk: Amlogic: Add support for clock gates
>   ARM: clk: Amlogic: Add clk81 clock gates
>   ARM: DTS: Amlogic: Enable ethernet on meson8b
>   ARM: DTS: Amlogic: Enable ethernet on ODROID-C1
>
>  arch/arm/boot/dts/meson8b-odroidc1.dts   |  10 ++
>  arch/arm/boot/dts/meson8b.dtsi           |  25 ++++
>  drivers/clk/meson/clkc.c                 |  18 +++
>  drivers/clk/meson/clkc.h                 |  18 +++
>  drivers/clk/meson/meson8b-clkc.c         | 196 +++++++++++++++++++++++++++++++
>  drivers/pinctrl/meson/pinctrl-meson8b.c  |   2 +-
>  include/dt-bindings/clock/meson8b-clkc.h |  99 +++++++++++++++-
>  7 files changed, 365 insertions(+), 3 deletions(-)
