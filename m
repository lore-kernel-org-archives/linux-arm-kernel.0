From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 May 2017 10:40:05 +0200
Subject: [PATCH 3/3] ARM64: dts: Fix GXBB periphs pinctrl pull-enable
 register base
In-Reply-To: <1495549311-23660-4-git-send-email-narmstrong@baylibre.com>
References: <1495549311-23660-1-git-send-email-narmstrong@baylibre.com>
 <1495549311-23660-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495615205.14589.4.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-05-23 at 16:21 +0200, Neil Armstrong wrote:
> The pull-enable register base was wrongly copied from the meson8b pinctrl
> node,
> but was not used yet.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> 
> Fixes: c328666d58aa ("ARM64: dts: amlogic: Add Meson GX dtsi from GXBB")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> ?arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 6f8b301..47ca44d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -351,7 +351,7 @@
> ?		gpio: bank at 4b0 {
> ?			reg = <0x0 0x004b0 0x0 0x28>,
> ?			??????<0x0 0x004e8 0x0 0x14>,
> -			??????<0x0 0x00120 0x0 0x14>,
> +			??????<0x0 0x00520 0x0 0x14>,
> ?			??????<0x0 0x00430 0x0 0x40>;
> ?			reg-names = "mux", "pull", "pull-enable", "gpio";
> ?			gpio-controller;
