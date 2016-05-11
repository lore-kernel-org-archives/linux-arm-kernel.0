From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 11 May 2016 08:44:16 -0400
Subject: [PATCH v3 27/27] ARM: dts: exynos: Add RTC and I2C to Exynos5410
In-Reply-To: <1462910970-1812-28-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
 <1462910970-1812-28-git-send-email-krzk@kernel.org>
Message-ID: <b1f47282-f70e-4354-9146-9b4b27ba1726@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/10/2016 04:09 PM, Krzysztof Kozlowski wrote:
> Configure Exynos5410-specific properties of RTC, I2C and HSI2C nodes.
> This still does not enable them on the board level though.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5410.dtsi | 66 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
> index dd4d6d752865..ae64cb0a8efd 100644
> --- a/arch/arm/boot/dts/exynos5410.dtsi
> +++ b/arch/arm/boot/dts/exynos5410.dtsi
> @@ -114,6 +114,9 @@
>  			status = "disabled";
>  		};
>  
> +		/* i2c_0-3 are defined in exynos5.dtsi */
> +		/* hsi2c_4-7 are defined in exynos5xx.dtsi */
> +

I don't think these comments are needed. For each DTS, there are usually a lot of
nodes defined in higher levels of the DT hierarchy but isn't common to mention it.

Specially since the mentioned nodes are referenced here by their labels so it is
implicit that are defined in one of the included DTSI (or dtc will fail to build).

The actual change looks good to me though:

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
