From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 30 Apr 2017 22:37:48 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Move cros-ec-sbs to
 rk3288-veyron-chromebook-sbs
In-Reply-To: <20170430183054.24563-1-contact@paulk.fr>
References: <20170430183054.24563-1-contact@paulk.fr>
Message-ID: <2369975.a4dWayqU5d@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Am Sonntag, 30. April 2017, 20:30:52 CEST schrieb Paul Kocialkowski:
> This moves the cros-ec-sbs dtsi to a new rk3288-veyron-chromebook-sbs
> dtsi since it only concerns rk3288 veyron Chromebooks.
> 
> Other Chromebooks (such as the tegra124 nyans) also have sbs batteries
> and don't use this dtsi, that only makes sense when used with
> rk3288-veyron-chromebook anyway.

That isn't true. The gru series (rk3399-based) also uses the
sbs-battery [0]. And while it is currently limited to Rockchip-based
Chromebooks it is nevertheless used on more than one platform, so
the probability is high that it will be used in future series as well.

Also, it might be nice to also include some Chromeos people (there should
be some in the git logs, like Brian who submitted the Gru patches), as they
might be able to provide more detailed input.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi#n886

> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../boot/dts/{cros-ec-sbs.dtsi => rk3288-veyron-chromebook-sbs.dtsi}    | 0
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts                                 | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-jerry.dts                               | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-pinky.dts                               | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-speedy.dts                              | 2 +-
>  5 files changed, 4 insertions(+), 4 deletions(-)
>  rename arch/arm/boot/dts/{cros-ec-sbs.dtsi => rk3288-veyron-chromebook-sbs.dtsi} (100%)
> 
> diff --git a/arch/arm/boot/dts/cros-ec-sbs.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/cros-ec-sbs.dtsi
> rename to arch/arm/boot/dts/rk3288-veyron-chromebook-sbs.dtsi
> diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> index d33f5763c39c..f217a978e47a 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> @@ -45,7 +45,7 @@
>  /dts-v1/;
>  
>  #include "rk3288-veyron-chromebook.dtsi"
> -#include "cros-ec-sbs.dtsi"
> +#include "rk3288-veyron-chromebook-sbs.dtsi"
>  
>  / {
>  	model = "Google Jaq";
> diff --git a/arch/arm/boot/dts/rk3288-veyron-jerry.dts b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
> index cdea751f2a8c..bec607574165 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-jerry.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-jerry.dts
> @@ -44,7 +44,7 @@
>  
>  /dts-v1/;
>  #include "rk3288-veyron-chromebook.dtsi"
> -#include "cros-ec-sbs.dtsi"
> +#include "rk3288-veyron-chromebook-sbs.dtsi"
>  
>  / {
>  	model = "Google Jerry";
> diff --git a/arch/arm/boot/dts/rk3288-veyron-pinky.dts b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
> index 995cff42fa43..c81ad5bf1121 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-pinky.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-pinky.dts
> @@ -44,7 +44,7 @@
>  
>  /dts-v1/;
>  #include "rk3288-veyron-chromebook.dtsi"
> -#include "cros-ec-sbs.dtsi"
> +#include "rk3288-veyron-chromebook-sbs.dtsi"
>  
>  / {
>  	model = "Google Pinky";
> diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> index cc0b78cefe34..8aea9c3ff6e2 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> @@ -44,7 +44,7 @@
>  
>  /dts-v1/;
>  #include "rk3288-veyron-chromebook.dtsi"
> -#include "cros-ec-sbs.dtsi"
> +#include "rk3288-veyron-chromebook-sbs.dtsi"
>  
>  / {
>  	model = "Google Speedy";
> 
