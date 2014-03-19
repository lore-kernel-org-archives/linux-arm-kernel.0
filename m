From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 19 Mar 2014 12:31:01 +0100
Subject: [PATCH v6 1/4] [media] exynos-scaler: Add DT bindings for SCALER
 driver
In-Reply-To: <1395213196-25972-2-git-send-email-shaik.ameer@samsung.com>
References: <1395213196-25972-1-git-send-email-shaik.ameer@samsung.com>
 <1395213196-25972-2-git-send-email-shaik.ameer@samsung.com>
Message-ID: <4637278.9G3gGkQ5GA@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

Thank you for the patch.

On Wednesday 19 March 2014 12:43:13 Shaik Ameer Basha wrote:
> This patch adds the DT binding documentation for the Exynos5420/5410
> based SCALER device driver.
> 
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/media/exynos5-scaler.txt   |   24 +++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/media/exynos5-scaler.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/exynos5-scaler.txt
> b/Documentation/devicetree/bindings/media/exynos5-scaler.txt new file mode
> 100644
> index 0000000..e1dd465
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/exynos5-scaler.txt
> @@ -0,0 +1,24 @@
> +* Samsung Exynos5 SCALER device
> +
> +SCALER is used for scaling, blending, color fill and color space
> +conversion on EXYNOS[5420/5410] SoCs.
> +
> +Required properties:
> +- compatible: should be "samsung,exynos5420-scaler" or
> +			"samsung,exynos5410-scaler"
> +- reg: should contain SCALER physical address location and length
> +- interrupts: should contain SCALER interrupt specifier
> +- clocks: should contain the SCALER clock phandle and specifier pair for
> +		each clock listed in clock-names property, according to
> +		the common clock bindings
> +- clock-names: should contain exactly one entry
> +		- "scaler" - IP bus clock

I'm not too familiar with the Exynos platform, but wouldn't it make sense to 
use a common name across IP cores for interface and function clocks ?

> +Example:
> +	scaler_0: scaler at 12800000 {
> +		compatible = "samsung,exynos5420-scaler";
> +		reg = <0x12800000 0x1000>;
> +		interrupts = <0 220 0>;
> +		clocks = <&clock 381>;
> +		clock-names = "scaler";
> +	};

-- 
Regards,

Laurent Pinchart
