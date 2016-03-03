From: abrestic@chromium.org (Andrew Bresticker)
Date: Thu, 3 Mar 2016 14:00:28 -0800
Subject: [PATCH] arm64: tegra210-smaug: Add gpio-key nodes
In-Reply-To: <1457034865-17826-1-git-send-email-rklein@nvidia.com>
References: <1457034865-17826-1-git-send-email-rklein@nvidia.com>
Message-ID: <CAL1qeaF-kpjtWExRo0KQK9bY5yyX_WG-p4W86zc-FL7uLRxWCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rhyland,

On Thu, Mar 3, 2016 at 11:54 AM, Rhyland Klein <rklein@nvidia.com> wrote:
> Add gpio-key nodes for the volumn controls, lid switch,
> tablet mode and power button.
>
> Signed-off-by: Rhyland Klein <rklein@nvidia.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>

> ---
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 43 +++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> index 750e85c45135..9c0ec3031e98 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> @@ -1,5 +1,7 @@
>  /dts-v1/;
>
> +#include <dt-bindings/input/input.h>
> +
>  #include "tegra210.dtsi"
>
>  / {
> @@ -76,6 +78,47 @@
>                 };
>         };
>
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               gpio-keys,name = "gpio-keys";
> +
> +               power {
> +                       label = "Power";
> +                       gpios = <&gpio TEGRA_GPIO(X, 5) GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_POWER>;
> +                       debounce-interval = <30>;
> +                       gpio-key,wakeup;
> +               };
> +
> +               lid {
> +                       label = "Lid";
> +                       gpios = <&gpio TEGRA_GPIO(B, 4) GPIO_ACTIVE_LOW>;
> +                       linux,input-type = <5>; /* EV_SW */
> +                       linux,code = <0>; /* SW_LID */
> +                       gpio-key,wakeup;
> +               };
> +
> +               tablet_mode {
> +                       label = "Tablet Mode";
> +                       gpios = <&gpio TEGRA_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
> +                       linux,input-type = <5>; /* EV_SW */
> +                       linux,code = <1>; /* SW_TABLET_MODE */
> +                       gpio-key,wakeup;
> +               };
> +
> +               volume_down {
> +                       label = "Volume Down";
> +                       gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_VOLUMEDOWN>;
> +               };
> +
> +               volume_up {
> +                       label = "Volume Up";
> +                       gpios = <&gpio TEGRA_GPIO(M, 4) GPIO_ACTIVE_LOW>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +               };
> +       };
> +
>         psci {
>                 compatible = "arm,psci-1.0";
>                 method = "smc";
> --
> 1.9.1
>
