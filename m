From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 05 Jun 2017 14:54:00 -0700
Subject: [PATCH] ARM64: dts: meson-gx: Fix sensors reporting from SCP
In-Reply-To: <20170605200350.1113-1-carlo@caione.org> (Carlo Caione's message
 of "Mon, 5 Jun 2017 22:03:50 +0200")
References: <20170605200350.1113-1-carlo@caione.org>
Message-ID: <m2mv9mdrt3.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> From: Carlo Caione <carlo@endlessm.com>
>
> Switch to use the new compatible for the SCPI sensors so that the
> sensor readings are reported using the correct scale.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 436b875..3128fa5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -200,7 +200,7 @@
>  		};
>  
>  		scpi_sensors: sensors {
> -			compatible = "arm,scpi-sensors";
> +			compatible = "amlogic,meson-gxbb-scpi-sensors";

Shouldn't this be:

			compatible = "amlogic,meson-gxbb-scpi-sensors", "arm,scpi-sensors";

For a safe fallback on kernels without the new compatible?

Kevin
