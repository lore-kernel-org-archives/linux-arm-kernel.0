From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 20 Oct 2016 17:38:48 +0200
Subject: [PATCH v3 5/6] ARM: sunxi: Remove useless allwinner,pull property
In-Reply-To: <42e249454ccf6b14e9ec266cb8d42a24f6d71d7b.1476971126.git-series.maxime.ripard@free-electrons.com>
References: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
 <42e249454ccf6b14e9ec266cb8d42a24f6d71d7b.1476971126.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20161020173848.be9cf97854f8933b3ce90d55@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Oct 2016 15:49:06 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> The allwinner,pull property set to NO_PULL was really considered our
> default (and wasn't even changing the default value in the code).
> 
> Remove these properties to make it obvious that we do not set anything in
> such a case.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/ntc-gr8-evb.dts                     |  4 +-
>  arch/arm/boot/dts/ntc-gr8.dtsi                        | 14 +-----
>  arch/arm/boot/dts/sun4i-a10-a1000.dts                 |  2 +-
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts            |  1 +-
>  arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts      |  4 +-
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts              |  1 +-
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts             |  2 +-
>  arch/arm/boot/dts/sun4i-a10-inet1.dts                 |  2 +-
>  arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts            |  2 +-
>  arch/arm/boot/dts/sun4i-a10-marsboard.dts             |  1 +-
>  arch/arm/boot/dts/sun4i-a10-mk802.dts                 |  3 +-
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts        |  2 +-
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts               |  2 +-
>  arch/arm/boot/dts/sun4i-a10-pcduino2.dts              |  1 +-
>  arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts      |  3 +-
>  arch/arm/boot/dts/sun4i-a10.dtsi                      | 24 +--------
>  arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts          |  1 +-
>  arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts          |  2 +-
>  arch/arm/boot/dts/sun5i-a10s-mk802.dts                |  2 +-
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts      |  2 +-
>  arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts         |  2 +-
>  arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts              |  2 +-
>  arch/arm/boot/dts/sun5i-a10s.dtsi                     |  7 +--
>  arch/arm/boot/dts/sun5i-a13-hsg-h702.dts              |  1 +-
>  arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts       |  3 +-
>  arch/arm/boot/dts/sun5i-a13-olinuxino.dts             |  2 +-
>  arch/arm/boot/dts/sun5i-a13-utoo-p66.dts              |  1 +-
>  arch/arm/boot/dts/sun5i-a13.dtsi                      |  3 +-
>  arch/arm/boot/dts/sun5i-r8-chip.dts                   |  2 +-
>  arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi  |  2 +-
>  arch/arm/boot/dts/sun5i.dtsi                          |  7 +--
>  arch/arm/boot/dts/sun6i-a31-app4-evb1.dts             |  1 +-
>  arch/arm/boot/dts/sun6i-a31-colombus.dts              |  1 +-
>  arch/arm/boot/dts/sun6i-a31-hummingbird.dts           |  2 +-
>  arch/arm/boot/dts/sun6i-a31-i7.dts                    |  2 +-
>  arch/arm/boot/dts/sun6i-a31-m9.dts                    |  2 +-
>  arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts      |  2 +-
>  arch/arm/boot/dts/sun6i-a31.dtsi                      | 13 +----
>  arch/arm/boot/dts/sun6i-a31s-primo81.dts              |  1 +-
>  arch/arm/boot/dts/sun6i-a31s-sina31s.dts              |  1 +-
>  arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts      |  3 +-
>  arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts      |  3 +-
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts              |  2 +-
>  arch/arm/boot/dts/sun7i-a20-bananapro.dts             |  5 +--
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts           |  1 +-
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts            |  6 +--
>  arch/arm/boot/dts/sun7i-a20-hummingbird.dts           |  4 +-
>  arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts             |  4 +-
>  arch/arm/boot/dts/sun7i-a20-itead-ibox.dts            |  1 +-
>  arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts             |  2 +-
>  arch/arm/boot/dts/sun7i-a20-m3.dts                    |  1 +-
>  arch/arm/boot/dts/sun7i-a20-mk808c.dts                |  2 +-
>  arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts        |  4 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts        |  2 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts  |  1 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts       |  3 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts       |  1 +-
>  arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts         |  4 +-
>  arch/arm/boot/dts/sun7i-a20-orangepi.dts              |  4 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts         |  3 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3.dts              |  2 +-
>  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts        |  3 +-
>  arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts      |  1 +-
>  arch/arm/boot/dts/sun7i-a20.dtsi                      | 37 +------------
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi                  | 10 +---
>  arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts |  1 +-
>  arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts |  1 +-
>  arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts        |  1 +-
>  arch/arm/boot/dts/sun8i-a33-olinuxino.dts             |  3 +-
>  arch/arm/boot/dts/sun8i-a33.dtsi                      |  1 +-
>  arch/arm/boot/dts/sun8i-a83t.dtsi                     |  3 +-
>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts       |  3 +-
>  arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts             |  2 +-
>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts             |  4 +-
>  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts          |  3 +-
>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts           |  3 +-
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts            |  3 +-
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts          |  1 +-
>  arch/arm/boot/dts/sun8i-h3.dtsi                       | 12 +----
>  arch/arm/boot/dts/sun8i-r16-parrot.dts                |  3 +-
>  arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi  |  2 +-
>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts           |  1 +-
>  arch/arm/boot/dts/sun9i-a80-optimus.dts               |  4 +-
>  arch/arm/boot/dts/sun9i-a80.dtsi                      |  6 +--
>  arch/arm/boot/dts/sunxi-common-regulators.dtsi        |  4 +-
>  85 files changed, 0 insertions(+), 302 deletions(-)
	[snip]

Is it really usefull to change all these files while in a previous
patch you were writing:
> The generic pin configuration and multiplexing should be preferred now,
> even though we still support the old one.
?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
