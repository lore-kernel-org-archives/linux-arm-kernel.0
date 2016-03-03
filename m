From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 11:54:17 +0100
Subject: [RFC 05/15] phy: hi6220: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-6-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1777963.D97F7d0Oik@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:31 Krzysztof Kozlowski wrote:
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -225,6 +225,7 @@ config PHY_MT65XX_USB3
>  config PHY_HI6220_USB
>         tristate "hi6220 USB PHY support"
>         depends on (ARCH_HISI && ARM64) || COMPILE_TEST
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select GENERIC_PHY
>         select MFD_SYSCON
>         help
> -- 
> 2.5.0
> 

This is indeed required, and seems to be what caused the problem
you saw in the first place.

	Arnd
