From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 12 Mar 2017 13:51:31 -0700
Subject: [PATCH v2 8/8] ARM: dts: s5pv210: Fix infinite interrupt in soft
 mode
In-Reply-To: <20170311172527.16368-9-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-9-krzk@kernel.org>
Message-ID: <d5299b45-22c1-805f-b388-84af933a4434@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2017 09:25 AM, Krzysztof Kozlowski wrote:
> In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> of an interrupt.  The interrupt has to be cleared, because otherwise
> system enters infinite interrupt handling loop.
>
> Use a samsung,s3c6410-wdt compatible to select appropriate quirk for
> clearing the watchdog interrupt.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/s5pv210.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
> index a853918be43f..726c5d0dbd5b 100644
> --- a/arch/arm/boot/dts/s5pv210.dtsi
> +++ b/arch/arm/boot/dts/s5pv210.dtsi
> @@ -310,7 +310,7 @@
>  		};
>
>  		watchdog: watchdog at e2700000 {
> -			compatible = "samsung,s3c2410-wdt";
> +			compatible = "samsung,s3c6410-wdt";
>  			reg = <0xe2700000 0x1000>;
>  			interrupt-parent = <&vic0>;
>  			interrupts = <26>;
>
