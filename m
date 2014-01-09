From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Jan 2014 10:20:07 +0100
Subject: [PATCH v5 4/4] [media] exynos-scaler: Add DT bindings for SCALER
 driver
In-Reply-To: <1389238094-19386-5-git-send-email-shaik.ameer@samsung.com>
References: <1389238094-19386-1-git-send-email-shaik.ameer@samsung.com>
 <1389238094-19386-5-git-send-email-shaik.ameer@samsung.com>
Message-ID: <2542868.mVreZlxTcT@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Thursday, January 09, 2014 08:58:14 AM Shaik Ameer Basha wrote:
> This patch adds the DT binding documentation for the
> Exynos5420/5410 based SCALER device driver.
> 
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/media/exynos5-scaler.txt   |   22 ++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/exynos5-scaler.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/exynos5-scaler.txt b/Documentation/devicetree/bindings/media/exynos5-scaler.txt
> new file mode 100644
> index 0000000..9328e7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/exynos5-scaler.txt
> @@ -0,0 +1,22 @@
> +* Samsung Exynos5 SCALER device
> +
> +SCALER is used for scaling, blending, color fill and color space
> +conversion on EXYNOS[5420/5410] SoCs.
> +
> +Required properties:
> +- compatible: should be "samsung,exynos5420-scaler" or
> +			"samsung,exynos5410-scaler"
> +- reg: should contain SCALER physical address location and length
> +- interrupts: should contain SCALER interrupt number
> +- clocks: should contain the SCALER clock specifier, from the
> +			common clock bindings
> +- clock-names: should be "scaler"
> +
> +Example:
> +	scaler_0: scaler at 12800000 {
> +		compatible = "samsung,exynos5420-scaler";
> +		reg = <0x12800000 0x1000>;
> +		interrupts = <0 220 0>;
> +		clocks = <&clock 381>;
> +		clock-names = "scaler";
> +	};

Your patchset adds support for EXYNOS5 SCALER but doesn't add any real
users of it yet.  Could you please explain why?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
