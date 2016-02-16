From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 16 Feb 2016 07:31:36 -0800
Subject: [PATCH v12 3/4] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
In-Reply-To: <1455611785-2407-4-git-send-email-fu.wei@linaro.org>
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-4-git-send-email-fu.wei@linaro.org>
Message-ID: <56C340D8.2050302@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2016 12:36 AM, fu.wei at linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This can be a example of adding SBSA Generic Watchdog device node
> into some dts files for the Soc which contains SBSA Generic Watchdog.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> index 2874d92..0a8ca1d 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> @@ -84,6 +84,14 @@
>   			clock-names = "uartclk", "apb_pclk";
>   		};
>
> +		watchdog0: watchdog at e0bb0000 {
> +			compatible = "arm,sbsa-gwdt";
> +			reg = <0x0 0xe0bc0000 0 0x1000>,
> +				<0x0 0xe0bb0000 0 0x1000>;
> +			interrupts = <0 337 4>;
> +			timeout-sec = <15>;
> +		};
> +
>   		spi0: ssp at e1020000 {
>   			status = "disabled";
>   			compatible = "arm,pl022", "arm,primecell";
>
