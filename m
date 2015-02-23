From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 23 Feb 2015 13:31:29 +0200
Subject: [PATCH 07/12] ARM: DT: apq8064: Add usb host support to CM QS-600
In-Reply-To: <1424678144-13224-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678144-13224-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <54EB0F91.2050002@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/23/15 09:55, Srinivas Kandagatla wrote:
> From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> 
> This patch adds device tree nodes to support two usb hosts on Compulab QS600 board.
> 
> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

> ---
>  arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> index 6e62f24..af2e075 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
> @@ -41,6 +41,22 @@
>  			};
>  		};
>  
> +		usb3_phy:phy at 12520000 {
> +			status = "ok";
> +		};
> +		
> +		usb4_phy:phy at 12530000 {
> +			status = "ok";
> +		};
> +		
> +		usb3: usb at 12520000 {
> +			status = "ok";
> +		};
> +		
> +		usb4: usb at 12530000 {
> +			status = "ok";
> +		};
> +
>  		/* on board fixed 3.3v supply */
>  		v3p3_pcieclk: v3p3-pcieclk {
>  			compatible = "regulator-fixed";
> 

-- 
Regards,
Igor.
