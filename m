From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Oct 2015 09:07:02 -0500
Subject: [PATCH 2/2] ARM: dts: change gpio-key,wakeup property to boolean
In-Reply-To: <1444743164-17735-2-git-send-email-sudeep.holla@arm.com>
References: <1444743164-17735-1-git-send-email-sudeep.holla@arm.com>
 <1444743164-17735-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAL_JsqKDrvxas-x9QoLEs3yuDtEY+0u5qJZ4ZPiRQX0SrMKY2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 8:32 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Keyboard driver for GPIO buttons(gpio-keys) checks for the legacy
> "gpio-key,wakeup" boolean property to enable gpio buttons as wakeup
> source.
>
> Few dts files assign value "1" to gpio-key,wakeup and in one instance a
> value "0" is assigned probably assuming it won't be enabled as a wakeup
> source. Since the presence of the boolean property indicates it is
> enabled, value of "0" have no value.
>
> This patch removes the property where value "0" is assigned and removes
> the value "1" in most of the other cases.

Why don't you just change everything to wakeup-source.

Rob

>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: spear-devel at list.st.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts      | 3 +--
>  arch/arm/boot/dts/rk3066a-rayeager.dts      | 2 +-
>  arch/arm/boot/dts/rk3188-radxarock.dts      | 2 +-
>  arch/arm/boot/dts/rk3288-evb.dtsi           | 2 +-
>  arch/arm/boot/dts/rk3288-firefly.dtsi       | 2 +-
>  arch/arm/boot/dts/rk3288-popmetal.dts       | 2 +-
>  arch/arm/boot/dts/rk3288-r89.dts            | 2 +-
>  arch/arm/boot/dts/spear1310-evb.dts         | 2 +-
>  arch/arm/boot/dts/spear1340-evb.dts         | 2 +-
>  arch/arm/boot/dts/spear320-hmi.dts          | 4 ++--
>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts | 2 +-
>  11 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> index c0273755431a..71a15772cda6 100644
> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> @@ -74,7 +74,7 @@
>                         linux,code = <116>;
>                         label = "GPIO Key Power";
>                         linux,input-type = <1>;
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         debounce-interval = <100>;
>                 };
>                 button at 1 {
> @@ -82,7 +82,6 @@
>                         linux,code = <104>;
>                         label = "GPIO Key Vol-";
>                         linux,input-type = <1>;
> -                       gpio-key,wakeup = <0>;
>                         debounce-interval = <100>;
>                 };
>                 /* VOL+ comes somehow thru the ADC */
> diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
> index e36383c701dc..72bf52a04506 100644
> --- a/arch/arm/boot/dts/rk3066a-rayeager.dts
> +++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
> @@ -65,7 +65,7 @@
>                 #size-cells = <0>;
>
>                 button at 0 {
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
>                         label = "GPIO Power";
>                         linux,code = <116>;
> diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
> index d2180e5d2b05..ba6b174777e7 100644
> --- a/arch/arm/boot/dts/rk3188-radxarock.dts
> +++ b/arch/arm/boot/dts/rk3188-radxarock.dts
> @@ -63,7 +63,7 @@
>                         linux,code = <116>;
>                         label = "GPIO Key Power";
>                         linux,input-type = <1>;
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         debounce-interval = <100>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
> index f6d2e7894b05..ab013155f04f 100644
> --- a/arch/arm/boot/dts/rk3288-evb.dtsi
> +++ b/arch/arm/boot/dts/rk3288-evb.dtsi
> @@ -103,7 +103,7 @@
>                         linux,code = <116>;
>                         label = "GPIO Key Power";
>                         linux,input-type = <1>;
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         debounce-interval = <100>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
> index 20fa0ef0b96b..4fa2dedd0c7a 100644
> --- a/arch/arm/boot/dts/rk3288-firefly.dtsi
> +++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
> @@ -67,7 +67,7 @@
>                 #size-cells = <0>;
>
>                 button at 0 {
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>                         label = "GPIO Power";
>                         linux,code = <116>;
> diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
> index f82b956ebf17..9b7f389c38e5 100644
> --- a/arch/arm/boot/dts/rk3288-popmetal.dts
> +++ b/arch/arm/boot/dts/rk3288-popmetal.dts
> @@ -74,7 +74,7 @@
>                         linux,code = <116>;
>                         label = "GPIO Key Power";
>                         linux,input-type = <1>;
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         debounce-interval = <100>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
> index 14b9fc73c8a4..2ee425523f5c 100644
> --- a/arch/arm/boot/dts/rk3288-r89.dts
> +++ b/arch/arm/boot/dts/rk3288-r89.dts
> @@ -73,7 +73,7 @@
>                         linux,code = <116>;
>                         label = "GPIO Key Power";
>                         linux,input-type = <1>;
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         debounce-interval = <100>;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
> index e48857249ce7..6673d74ab0c0 100644
> --- a/arch/arm/boot/dts/spear1310-evb.dts
> +++ b/arch/arm/boot/dts/spear1310-evb.dts
> @@ -161,7 +161,7 @@
>                                 linux,code = <0x100>;
>                                 gpios = <&gpio0 7 0x4>;
>                                 debounce-interval = <20>;
> -                               gpio-key,wakeup = <1>;
> +                               gpio-key,wakeup;
>                         };
>                 };
>
> diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
> index c611f5606dfe..9071344fa47c 100644
> --- a/arch/arm/boot/dts/spear1340-evb.dts
> +++ b/arch/arm/boot/dts/spear1340-evb.dts
> @@ -223,7 +223,7 @@
>                                 linux,code = <0x100>;
>                                 gpios = <&gpio1 1 0x4>;
>                                 debounce-interval = <20>;
> -                               gpio-key,wakeup = <1>;
> +                               gpio-key,wakeup;
>                         };
>                 };
>
> diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
> index 0aa6fef5ce22..3c5b28c0fce4 100644
> --- a/arch/arm/boot/dts/spear320-hmi.dts
> +++ b/arch/arm/boot/dts/spear320-hmi.dts
> @@ -141,7 +141,7 @@
>                                 linux,code = <0x100>;
>                                 gpios = <&stmpegpio 3 0x4>;
>                                 debounce-interval = <20>;
> -                               gpio-key,wakeup = <1>;
> +                               gpio-key,wakeup;
>                         };
>
>                         button at 2 {
> @@ -149,7 +149,7 @@
>                                 linux,code = <0x200>;
>                                 gpios = <&stmpegpio 2 0x4>;
>                                 debounce-interval = <20>;
> -                               gpio-key,wakeup = <1>;
> +                               gpio-key,wakeup;
>                         };
>                 };
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> index 401a81231eb9..58a2829d9ea7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
> @@ -71,7 +71,7 @@
>                 pinctrl-0 = <&pwr_key>;
>
>                 button at 0 {
> -                       gpio-key,wakeup = <1>;
> +                       gpio-key,wakeup;
>                         gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
>                         label = "GPIO Power";
>                         linux,code = <116>;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
