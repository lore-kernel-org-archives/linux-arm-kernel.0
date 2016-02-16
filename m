From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 16 Feb 2016 07:31:09 -0800
Subject: [PATCH v12 2/4] ARM64: add SBSA Generic Watchdog device node in
 foundation-v8.dts
In-Reply-To: <1455611785-2407-3-git-send-email-fu.wei@linaro.org>
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-3-git-send-email-fu.wei@linaro.org>
Message-ID: <56C340BD.2050700@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2016 12:36 AM, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This can be a example of adding SBSA Generic Watchdog device node
> into some dts files for the Soc which contains SBSA Generic Watchdog.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm64/boot/dts/arm/foundation-v8.dts | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
> index 4eac8dc..66cb9aa 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8.dts
> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
> @@ -237,4 +237,11 @@
>   			};
>   		};
>   	};
> +	watchdog at 2a440000 {
> +		compatible = "arm,sbsa-gwdt";
> +		reg = <0x0 0x2a440000 0 0x1000>,
> +			<0x0 0x2a450000 0 0x1000>;
> +		interrupts = <0 27 4>;
> +		timeout-sec = <30>;
> +	};
>   };
>
