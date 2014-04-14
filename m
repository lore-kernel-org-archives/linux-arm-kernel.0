From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 Apr 2014 16:37:02 +0200
Subject: [PATCH V4 1/5] phy: Add new Exynos5 USB 3.0 PHY driver
In-Reply-To: <1396967803-28868-2-git-send-email-gautam.vivek@samsung.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
 <1396967803-28868-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <534BF28E.7040906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/14 16:36, Vivek Gautam wrote:
> diff --git a/Documentation/devicetree/bindings/phy/samsung-phy.txt b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> index 28f9edb..6d99ba9 100644
> --- a/Documentation/devicetree/bindings/phy/samsung-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/samsung-phy.txt
> @@ -74,3 +74,45 @@ phy-consumer at 12340000 {
>  
>  Refer to DT bindings documentation of particular PHY consumer devices for more
>  information about required PHYs and the way of specification.
> +
> +Samsung Exynos5 SoC series USB DRD PHY controller
> +--------------------------------------------------
> +
> +Required properties:
> +- compatible : Should be set to one of the following supported values:
> +	- "samsung,exynos5250-usbdrd-phy" - for exynos5250 SoC,
> +	- "samsung,exynos5420-usbdrd-phy" - for exynos5420 SoC.
> +- reg : Register offset and length of USB DRD PHY register set;
> +- clocks: Clock IDs array as required by the controller
> +- clock-names: names of clocks correseponding to IDs in the clock property;
> +	       Required clocks:
> +	- phy: main PHY clock (same as USB DRD controller i.e. DWC3 IP clock),
> +	       used for register access.
> +	- ref: PHY's reference clock (usually crystal clock), associated by
> +	       phy name, used to determine bit values for clock settings
> +	       register.
> +	Additional clock required for Exynos5420:
> +	- usb30_sclk_100m: Additional special clock used for PHY operation
> +			   depicted as 'sclk_usbphy30' in CMU of Exynos5420.
> +- samsung,syscon-phandle: phandle for syscon interface, which is used to
> +			  control pmu registers for power isolation.

Why to append "-phandle" to the property's name ? If this is for PMU
perhaps make it more explicit and name it: samsung,pmu-syscon or
samsung,pmureg ?

> +- samsung,pmu-offset: phy power control register offset to pmu-system-controller
> +		      base.
> +- #phy-cells : from the generic PHY bindings, must be 1;
> +
> +For "samsung,exynos5250-usbdrd-phy" and "samsung,exynos5420-usbdrd-phy"
> +compatible PHYs, the second cell in the PHY specifier identifies the
> +PHY id, which is interpreted as follows:
> +  0 - UTMI+ type phy,
> +  1 - PIPE3 type phy,

-- 
Thanks,
Sylwester
