From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Oct 2017 17:09:20 -0500
Subject: [PATCH] pwm: meson: use generic compatibles
In-Reply-To: <20171013091642.31948-1-jbrunet@baylibre.com>
References: <20171013091642.31948-1-jbrunet@baylibre.com>
Message-ID: <20171017220920.acjq6dr3ntf7xkid@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 11:16:42AM +0200, Jerome Brunet wrote:
> The meson pwm driver seems to be compatible with more SoCs than
> initially thought. Let's use the most generic compatibles he have in
> DT instead of the gxbb specific ones
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-meson.txt |  6 +++---
>  drivers/pwm/pwm-meson.c                             | 12 ++++++------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> index 1ee81321c35e..439e05030553 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
> @@ -3,8 +3,8 @@ Amlogic Meson PWM Controller
>  
>  Required properties:
>  - compatible: Shall contain "amlogic,meson8b-pwm"
> -                         or "amlogic,meson-gxbb-pwm"
> -                         or "amlogic,meson-gxbb-ao-pwm"
> +                         or "amlogic,meson-gx-pwm"
> +                         or "amlogic,meson-gx-ao-pwm"

I've already said the same on other patches, but so other 
maintainers see it, this seems like pointless, non-backwards compatible 
change.

Rob
