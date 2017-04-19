From: icenowy@aosc.io (icenowy at aosc.io)
Date: Wed, 19 Apr 2017 23:36:36 +0800
Subject: [PATCH 2/4] ARM: sunxi: Drop mmc0_cd_pin_reference_design pinmux
 setting
In-Reply-To: <20170419050919.6762-3-wens@csie.org>
References: <20170419050919.6762-1-wens@csie.org>
 <20170419050919.6762-3-wens@csie.org>
Message-ID: <442479d213a83c73cd7ff44538d234ea@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-04-19 13:09?Chen-Yu Tsai ???
> As part of our effort to move pinctrl/GPIO interlocking into the
> driver where it belongs, this patch drops the definition and usage
> of the mmc0_cd_pin_reference_design pinmux setting for the default
> mmc0 card detect GPIO pin.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts                | 2 +-
>  arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts           | 2 +-
>  arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts      | 2 +-
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts           | 2 +-
>  arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts     | 2 +-
>  arch/arm/boot/dts/sun4i-a10-gemei-g9.dts             | 2 +-
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts            | 2 +-
>  arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts         | 2 +-
>  arch/arm/boot/dts/sun4i-a10-inet1.dts                | 2 +-
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts            | 2 +-
>  arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts         | 2 +-
>  arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts | 2 +-
>  arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts           | 2 +-
>  arch/arm/boot/dts/sun4i-a10-marsboard.dts            | 2 +-
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts           | 2 +-
>  arch/arm/boot/dts/sun4i-a10-mk802.dts                | 2 +-
>  arch/arm/boot/dts/sun4i-a10-mk802ii.dts              | 2 +-
>  arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts       | 2 +-
>  arch/arm/boot/dts/sun4i-a10-pcduino.dts              | 2 +-
>  arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts     | 2 +-
>  arch/arm/boot/dts/sun4i-a10.dtsi                     | 6 ------
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts          | 2 +-
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts           | 2 +-
>  arch/arm/boot/dts/sun7i-a20-hummingbird.dts          | 2 +-
>  arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts            | 2 +-
>  arch/arm/boot/dts/sun7i-a20-icnova-swac.dts          | 2 +-
>  arch/arm/boot/dts/sun7i-a20-itead-ibox.dts           | 2 +-
>  arch/arm/boot/dts/sun7i-a20-m3.dts                   | 2 +-
>  arch/arm/boot/dts/sun7i-a20-mk808c.dts               | 2 +-
>  arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts       | 2 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts       | 2 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts      | 2 +-
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts      | 2 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts        | 2 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3.dts             | 2 +-
>  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts       | 2 +-
>  arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts     | 2 +-
>  arch/arm/boot/dts/sun7i-a20.dtsi                     | 6 ------
>  38 files changed, 36 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index f2a01fe2bebc..f80d37ddc4c6 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -171,7 +171,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> index 942d739a4384..6b02de592a02 100644
> --- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> @@ -109,7 +109,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> index 17f8c5ec011c..a7d61994b8fd 100644
> --- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> @@ -128,7 +128,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index d844938e2aa7..a698a994e5ff 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -142,7 +142,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
> b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
> index aad3bec1cb39..e0777ae808c7 100644
> --- a/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
> @@ -163,7 +163,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> index 9616cdecce93..d8bfd7b74916 100644
> --- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
> @@ -146,7 +146,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH01 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> index a1a7282199d5..856cfc9128e6 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> @@ -107,7 +107,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> index bc4351bb851f..6506595268b2 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
> @@ -79,7 +79,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts
> b/arch/arm/boot/dts/sun4i-a10-inet1.dts
> index b8923b92cb36..d51d8c302daf 100644
> --- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
> @@ -161,7 +161,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> index a1a2bbb3f9d3..a8e479fe43ca 100644
> --- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> @@ -147,7 +147,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> index 4a27eb9102cd..2acb89a87d41 100644
> --- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> @@ -305,7 +305,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
> b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
> index 4e798f014c99..92e3e030ced3 100644
> --- a/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
> @@ -100,7 +100,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
> b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
> index 308dc1513041..92b2d4af3d21 100644
> --- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
> @@ -140,7 +140,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> index 98a5f7258dca..0f927da28ee1 100644
> --- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
> @@ -141,7 +141,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> index 484c57493bd2..a5ed9e4e22c6 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> @@ -97,7 +97,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-mk802.dts
> b/arch/arm/boot/dts/sun4i-a10-mk802.dts
> index 2b75745cd246..81db6824a2c7 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mk802.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mk802.dts
> @@ -72,7 +72,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
> b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
> index c861fa7e356c..e74a881fd9a7 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mk802ii.dts
> @@ -83,7 +83,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> index 3a2522a9419d..462412ee903c 100644
> --- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
> @@ -145,7 +145,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> index 83596fd2ccfc..84f55e76df0c 100644
> --- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
> @@ -147,7 +147,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
> b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
> index a68c7cc53b94..c0f8c88b5a7d 100644
> --- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
> @@ -149,7 +149,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi 
> b/arch/arm/boot/dts/sun4i-a10.dtsi
> index b63668ece151..41c2579143fd 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -1030,12 +1030,6 @@
>  				bias-pull-up;
>  			};
> 
> -			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
> -				pins = "PH1";
> -				function = "gpio_in";
> -				bias-pull-up;
> -			};
> -
>  			ps20_pins_a: ps20 at 0 {
>  				pins = "PI20", "PI21";
>  				function = "ps2";
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index a2eab7aa80e0..7ac5bcc9f972 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -137,7 +137,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 102903e83bd2..4ebeecf9c3d7 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -178,7 +178,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> index 99c00b9a1546..6e6264cd69f8 100644
> --- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> @@ -160,7 +160,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v0>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> index 4da49717da21..e5cbcad3a556 100644
> --- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> @@ -157,7 +157,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
> b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
> index 28d3abbdc2d4..794e7617f545 100644
> --- a/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
> @@ -104,7 +104,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 8 5 GPIO_ACTIVE_HIGH>; /* PI5 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> index d52222c82cb8..8a8a6dbcd414 100644
> --- a/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
> @@ -121,7 +121,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts
> b/arch/arm/boot/dts/sun7i-a20-m3.dts
> index 86f69813683e..43c94787ef07 100644
> --- a/arch/arm/boot/dts/sun7i-a20-m3.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
> @@ -117,7 +117,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
> b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
> index c4ee30709f3a..f7413094183c 100644
> --- a/arch/arm/boot/dts/sun7i-a20-mk808c.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-mk808c.dts
> @@ -109,7 +109,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v0>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> index 1af5b46862cb..64c8ef9a2756 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
> @@ -187,7 +187,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> index dcd0f7a0dffa..2ce1a9f13a17 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
> @@ -130,7 +130,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index e7d45425758c..097bd755764c 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -131,7 +131,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index def0ad8395bb..0b7403e4d687 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -198,7 +198,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> index f47a5c46bc20..39bc73db72e5 100644
> --- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> @@ -130,7 +130,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> index 98177b5891cb..777152a3df0f 100644
> --- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> @@ -156,7 +156,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> index e19f17177755..f8d0aafb9f88 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> @@ -151,7 +151,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
> b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
> index c3078d4f1093..84462d7961f5 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
> @@ -120,7 +120,7 @@
> 
>  &mmc0 {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
> +	pinctrl-0 = <&mmc0_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
>  	bus-width = <4>;
>  	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi 
> b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 93aa55970bd7..c03b59aaec82 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1190,12 +1190,6 @@
>  				bias-pull-up;
>  			};
> 
> -			mmc0_cd_pin_reference_design: mmc0_cd_pin at 0 {
> -				pins = "PH1";
> -				function = "gpio_in";
> -				bias-pull-up;

It needs pull up, so shouldn't be dropped.

(Although there may be external pull-up resistors on the board;
however last time we removed the pull-up on MMC node many boards
failed, so we cannot rely on external pull-up resistors)

> -			};
> -
>  			mmc2_pins_a: mmc2 at 0 {
>  				pins = "PC6", "PC7", "PC8",
>  				       "PC9", "PC10", "PC11";
