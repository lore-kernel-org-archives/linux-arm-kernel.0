From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 9 Nov 2015 07:11:10 -0800
Subject: [PATCH v3 4/4] ARM: dts: meson8b: Add watchdog node
In-Reply-To: <1446985137-25498-5-git-send-email-carlo@caione.org>
References: <1446985137-25498-1-git-send-email-carlo@caione.org>
 <1446985137-25498-5-git-send-email-carlo@caione.org>
Message-ID: <5640B78E.8010200@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2015 04:18 AM, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> With this patch we add the watchdog node in the meson8b DTS file.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index ee352bf..8bad557 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -105,6 +105,12 @@
>   			#interrupt-cells = <3>;
>   		};
>
> +		wdt: watchdog at c1109900 {
> +			compatible = "amlogic,meson8b-wdt";
> +			reg = <0xc1109900 0x8>;
> +			interrupts = <0 0 1>;
> +		};
> +
>   		timer at c1109940 {
>   			compatible = "amlogic,meson6-timer";
>   			reg = <0xc1109940 0x18>;
>
