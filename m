From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 Jan 2017 20:47:28 +0200
Subject: [PATCH v2 1/3] arm64: dts: exynos: Add missing unit name to
 Exynos7 SoC node
In-Reply-To: <1484069912-6534-2-git-send-email-javier@osg.samsung.com>
References: <1484069912-6534-1-git-send-email-javier@osg.samsung.com>
 <1484069912-6534-2-git-send-email-javier@osg.samsung.com>
Message-ID: <20170110184728.2nff4r634ics4wb3@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 02:38:30PM -0300, Javier Martinez Canillas wrote:
> This patch fixes the following DTC warning about a mismatch
> between a device node reg property and its unit name:
> 
> Node /soc has a reg or ranges property, but no unit name
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  arch/arm64/boot/dts/exynos/exynos7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> index 80aa60e38237..0d2fedc6ac2f 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
> @@ -69,7 +69,7 @@
>  		method = "smc";
>  	};
>  
> -	soc: soc {
> +	soc: soc at 0 {

This looks unnatural, like a fix just to silence the DTC. Mostly de do
not enumerate soc node, although there are few exceptions.

I would prefer ignore the warning... however I am happy to hear other opinions.

Best regards,
Krzysztof

>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 2.7.4
> 
