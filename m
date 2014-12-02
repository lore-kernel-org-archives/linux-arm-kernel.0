From: heesub.shin@samsung.com (Heesub Shin)
Date: Tue, 02 Dec 2014 15:17:18 +0900
Subject: [PATCH] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <547D596E.9000402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simons,

On 12/01/2014 09:59 PM, Sjoerd Simons wrote:
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/dts-v1/;
> +#include "exynos5800.dtsi"

Looking at exynos5800.dtsi, it derives from exynos5420.dtsi and seems 
having differences on clock and mfc. Is it proper to include 
exynos5800.dtsi here, instead of exynos5420.dtsi? It's just my curiosity 
as I am not in a position to know detailed things on the soc. Only 
semiconductor guys could answer this.

> +
> +/ {
> +	model = "Hardkernel Odroid XU3";
> +	compatible = "hardkernel,odroid-xu3", "samsung,exynos5800", "samsung,exynos5";
> +
> +	memory {
> +		reg = <0x20000000 0x80000000>;
> +	};

Start address above should be 0x40000000, not 0x20000000.

One more thing, having bootargs which specifies 'console=xxx' would be 
better.

regards,
heesub
