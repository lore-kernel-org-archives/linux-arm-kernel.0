From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 16 Mar 2015 09:04:12 +0100
Subject: [PATCH] ARM: sunxi: DT: Add stdout-path property
In-Reply-To: <1426448851-32204-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1426448851-32204-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <55068E7C.4060400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15-03-15 20:47, Maxime Ripard wrote:
> Add UART aliases and stdout-path property for all the Allwinner boards so that
> we won't have to rely on the bootargs' console= value, while working with
> legacy bootloaders.
>
> While we're at it, also remove the mentions of earlyprintk in the bootargs,
> that will remove our default bootargs entirely, and allow the kernel to boot on
> a system even if DEBUG_LL is configured for another system.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Erm, AFAIK stdout-path does not support aliases so you must put full paths
in there, see:

http://git.denx.de/?p=u-boot.git;a=commitdiff;h=f3133962f469a8b6b9ba237ba670f0ca7c88a02e

For a few examples.

Regards,

Hans

> ---
>   arch/arm/boot/dts/sun4i-a10-a1000.dts            |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-gemei-g9.dts         |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts     |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-marsboard.dts        |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-mk802.dts            |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-mk802ii.dts          |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  8 ++++++++
>   arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  7 +++++++
>   arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts     |  8 ++++++++
>   arch/arm/boot/dts/sun5i-a10s-mk802.dts           |  8 ++++++++
>   arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  4 ++++
>   arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    |  8 ++++++++
>   arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  4 ++++
>   arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  4 ++++
>   arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  4 ++++
>   arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  6 +++++-
>   arch/arm/boot/dts/sun6i-a31-colombus.dts         |  6 +++++-
>   arch/arm/boot/dts/sun6i-a31-hummingbird.dts      |  6 +++++-
>   arch/arm/boot/dts/sun6i-a31-i7.dts               |  6 +++++-
>   arch/arm/boot/dts/sun6i-a31-m9.dts               |  6 +++++-
>   arch/arm/boot/dts/sun6i-a31s-cs908.dts           |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  4 ++++
>   arch/arm/boot/dts/sun7i-a20-bananapro.dts        | 10 ++++++++++
>   arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-hummingbird.dts      |  4 ++++
>   arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-m3.dts               |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  4 ++++
>   arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts    |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-pcduino3.dts         |  8 ++++++++
>   arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts   |  8 ++++++++
>   arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  2 +-
>   arch/arm/boot/dts/sun9i-a80-optimus.dts          |  2 +-
>   42 files changed, 280 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index 648626bc58a1..f03281434e59 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -58,6 +58,14 @@
>   	model = "Mele A1000";
>   	compatible = "mele,a1000", "allwinner,sun4i-a10";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> index bebb803a9456..1a3c7ddc538a 100644
> --- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> @@ -54,6 +54,14 @@
>   / {
>   	model = "BA10 tvbox";
>   	compatible = "allwinner,ba10-tvbox", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &ehci0 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> index 97fca89eb92b..35fb163827de 100644
> --- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> @@ -54,6 +54,14 @@
>   / {
>   	model = "Chuwi V7 CW0825";
>   	compatible = "chuwi,v7-cw0825", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &ehci1 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index 07c2f64b14ee..0ba67d79c2b4 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -57,6 +57,14 @@
>   	model = "Cubietech Cubieboard";
>   	compatible = "cubietech,a10-cubieboard", "allwinner,sun4i-a10";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> index 0c7345380793..fbd638a38018 100644
> --- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> @@ -56,6 +56,14 @@
>   / {
>   	model = "Gemei G9 Tablet";
>   	compatible = "gemei,g9", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   /*
> diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> index 3cb067ed8715..f4437883fba7 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> @@ -58,6 +58,14 @@
>   	model = "Miniand Hackberry";
>   	compatible = "miniand,hackberry", "allwinner,sun4i-a10";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	reg_emac_3v3: emac-3v3 {
>   		compatible = "regulator-fixed";
>   		regulator-name = "emac-3v3";
> diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> index c88382aacc36..9f06b1805058 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> @@ -53,6 +53,14 @@
>   / {
>   	model = "Hyundai A7HD";
>   	compatible = "hyundai,a7hd", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &ehci1 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> index ab3bbc13db1c..e19ef52f3579 100644
> --- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> @@ -56,6 +56,14 @@
>   / {
>   	model = "INet-97F Rev 02";
>   	compatible = "primux,inet97fv2", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &ehci0 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> index 9ee86a700c2b..00c54d2a1824 100644
> --- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> @@ -57,6 +57,14 @@
>   	model = "HAOYU Electronics Marsboard A10";
>   	compatible = "haoyu,a10-marsboard", "allwinner,sun4i-a10";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> index dce9a341516b..0f24914c1a6e 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> @@ -57,6 +57,14 @@
>   / {
>   	model = "PineRiver Mini X-Plus";
>   	compatible = "pineriver,mini-xplus", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &ehci0 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts b/arch/arm/boot/dts/sun4i-a10-mk802.dts
> index e9a6886f0d51..0f1c99133c9c 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
> @@ -53,6 +53,14 @@
>   / {
>   	model = "MK802";
>   	compatible = "allwinner,mk802", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &ehci0 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
> index 802eda494d1c..f97aa6f523f4 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
> @@ -53,6 +53,14 @@
>   / {
>   	model = "MK802ii";
>   	compatible = "allwinner,mk802ii", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &ehci0 {
> diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> index 31dc2f1c3870..d13ea002a0ed 100644
> --- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> @@ -56,6 +56,14 @@
>   	model = "Olimex A10-OLinuXino-LIME";
>   	compatible = "olimex,a10-olinuxino-lime", "allwinner,sun4i-a10";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> index 6923ca75eb4a..be6948e41648 100644
> --- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> @@ -58,6 +58,13 @@
>   	model = "LinkSprite pcDuino";
>   	compatible = "linksprite,a10-pcduino", "allwinner,sun4i-a10";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>
>   	leds {
>   		compatible = "gpio-leds";
> diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> index 6c6fef780984..ceb0582ac90d 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> @@ -55,6 +55,14 @@
>   	model = "Auxtek t004 A10s hdmi tv-stick";
>   	compatible = "allwinner,auxtek-t004", "allwinner,sun5i-a10s";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
> index b21af87d9eae..e1a11e1d967d 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
> @@ -54,6 +54,14 @@
>   	model = "MK802-A10s";
>   	compatible = "allwinner,a10s-mk802", "allwinner,sun5i-a10s";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> index aa88ee887381..85a8745fffb3 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> @@ -65,6 +65,10 @@
>   		serial2 = &uart3;
>   	};
>
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
> index d42ce170e640..9980969d0986 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
> @@ -56,6 +56,14 @@
>   	model = "R7 A10s hdmi tv-stick";
>   	compatible = "allwinner,r7-tv-dongle", "allwinner,sun5i-a10s";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
> index b59255a445bc..adf78a234ffb 100644
> --- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
> @@ -59,6 +59,10 @@
>   	aliases {
>   		serial0 = &uart1;
>   	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &cpu0 {
> diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
> index bdb0a094223f..4a00bcee9272 100644
> --- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
> @@ -61,6 +61,10 @@
>   		serial0 = &uart1;
>   	};
>
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
> index d09c57b4905b..44401565533f 100644
> --- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
> @@ -63,6 +63,10 @@
>   		serial0 = &uart1;
>   	};
>
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
> index 98a74da02fd7..b7b1df4be460 100644
> --- a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
> @@ -58,8 +58,12 @@
>   	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
>   	compatible = "allwinner,app4-evb1", "allwinner,sun6i-a31";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
>   	chosen {
> -		bootargs = "earlyprintk console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
>   	};
>   };
>
> diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
> index d6e925c381a3..95d7ec2b2955 100644
> --- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
> @@ -58,8 +58,12 @@
>   	model = "WITS A31 Colombus Evaluation Board";
>   	compatible = "wits,colombus", "allwinner,sun6i-a31";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
>   	chosen {
> -		bootargs = "earlyprintk console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
>   	};
>   };
>
> diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> index d13c88c6509a..a2e9372de531 100644
> --- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
> @@ -58,8 +58,12 @@
>   	model = "Merrii A31 Hummingbird";
>   	compatible = "merrii,a31-hummingbird", "allwinner,sun6i-a31";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
>   	chosen {
> -		bootargs = "earlyprintk console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
>   	};
>   };
>
> diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
> index 049d3a6c09f2..ce37d69d3416 100644
> --- a/arch/arm/boot/dts/sun6i-a31-i7.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
> @@ -56,8 +56,12 @@
>   	model = "Mele I7 Quad top set box";
>   	compatible = "mele,i7", "allwinner,sun6i-a31";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
>   	chosen {
> -		bootargs = "console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
>   	};
>
>   	leds {
> diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
> index 5cbbbd696b00..29f5fc717b4f 100644
> --- a/arch/arm/boot/dts/sun6i-a31-m9.dts
> +++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
> @@ -56,8 +56,12 @@
>   	model = "Mele M9 / A1000G Quad top set box";
>   	compatible = "mele,m9", "allwinner,sun6i-a31";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
>   	chosen {
> -		bootargs = "earlyprintk console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
>   	};
>
>   	leds {
> diff --git a/arch/arm/boot/dts/sun6i-a31s-cs908.dts b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
> index bc3734f67cf0..d50b126ba614 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-cs908.dts
> +++ b/arch/arm/boot/dts/sun6i-a31s-cs908.dts
> @@ -53,6 +53,14 @@
>   / {
>   	model = "CSQ CS908 top set box";
>   	compatible = "csq,cs908", "allwinner,sun6i-a31s";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &usbphy {
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> index 6d1faf069e7e..b952ac445504 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -65,6 +65,10 @@
>   		serial2 = &uart7;
>   	};
>
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> index fb89fe7ed21b..9d9027f25a44 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> @@ -55,6 +55,16 @@
>   	model = "LeMaker Banana Pro";
>   	compatible = "lemaker,bananapro", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart2;
> +		serial2 = &uart7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 8c847eb70cad..3c817ac9360b 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -59,6 +59,14 @@
>   	model = "Cubietech Cubieboard2";
>   	compatible = "cubietech,cubieboard2", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 5af1df795f3c..613a19e63e58 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -59,6 +59,14 @@
>   	model = "Cubietech Cubietruck";
>   	compatible = "cubietech,cubietruck", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> index 8c30e126abe6..d3f15c2e721e 100644
> --- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> @@ -67,6 +67,10 @@
>   		serial4 = &uart5;
>   	};
>
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	reg_mmc3_vdd: mmc3_vdd {
>   		compatible = "regulator-fixed";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> index c11574c2b931..3f99b3f222a7 100644
> --- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> @@ -57,6 +57,14 @@
>   	model = "I12 / Q5 / QT840A A20 tvbox";
>   	compatible = "allwinner,i12-tvbox", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
> index 44ba67dfb494..f2fb26e7d6e5 100644
> --- a/arch/arm/boot/dts/sun7i-a20-m3.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
> @@ -59,6 +59,14 @@
>   	model = "Mele M3";
>   	compatible = "mele,m3", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> index 68efd2f33307..6592cb21e32c 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> @@ -60,6 +60,14 @@
>   	model = "Olimex A20-OLinuXino-LIME";
>   	compatible = "olimex,a20-olinuxino-lime", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index 5e57157f742d..3a7a2c2b488c 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -57,6 +57,14 @@
>   	model = "Olimex A20-OLinuXino-LIME2";
>   	compatible = "olimex,a20-olinuxino-lime2", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index f6f06311e25b..82802b6cb192 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -68,6 +68,10 @@
>   		spi1 = &spi2;
>   	};
>
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> index 632b8a9e092f..810c5f764595 100644
> --- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> @@ -55,6 +55,14 @@
>   	model = "LinkSprite pcDuino3 Nano";
>   	compatible = "linksprite,pcduino3-nano", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> index 09ec96b2b7d7..cd05267781fb 100644
> --- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> @@ -59,6 +59,14 @@
>   	model = "LinkSprite pcDuino3";
>   	compatible = "linksprite,pcduino3", "allwinner,sun7i-a20";
>
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> index ea133bd3dd87..2ad3b09dcb6f 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> @@ -57,6 +57,14 @@
>   / {
>   	model = "Wexler TAB7200";
>   	compatible = "wexler,tab7200", "allwinner,sun7i-a20";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>   };
>
>   &cpu0 {
> diff --git a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
> index 4cb25f8267c8..f5658d123f9b 100644
> --- a/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
> +++ b/arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
> @@ -64,7 +64,7 @@
>   	};
>
>   	chosen {
> -		bootargs = "earlyprintk console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
>   	};
>   };
>
> diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> index e53f2656c2d0..211996cd0a4d 100644
> --- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
> +++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
> @@ -64,7 +64,7 @@
>   	};
>
>   	chosen {
> -		bootargs = "earlyprintk console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
>   	};
>
>   	leds {
>
