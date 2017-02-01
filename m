From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 1 Feb 2017 14:55:42 +0000
Subject: [STLinux Kernel] [PATCH v2 07/10] ARM: dts: STiH410-b2260:
 Identify the UART RTS line
In-Reply-To: <20170201143145.31962-8-lee.jones@linaro.org>
References: <20170201143145.31962-1-lee.jones@linaro.org>
 <20170201143145.31962-8-lee.jones@linaro.org>
Message-ID: <20170201145542.GC28760@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Feb 2017, Lee Jones wrote:

> When hardware flow-control is disabled, manual toggling of the UART's
> reset line (RTS) using userland applications (e.g. stty) is not
> possible, since the ASC IP does not provide this functionality in the
> same was as some other IPs do.  Thus, we have to do this manually.
> This patch configures the UART RTS line as a GPIO for manipulation
> within the UART driver when HW flow-control is not enabled.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>

> ---
>  arch/arm/boot/dts/stih410-b2260.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index 06b0696..fa16aba 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -63,6 +63,7 @@
>  		uart0: serial at 9830000 {
>  			label = "LS-UART0";
>  			status = "okay";
> +			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
>  		};
>  
>  		/* Low speed expansion connector */
