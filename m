From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 12:00:14 +0100
Subject: [RFC 11/15] power: reset: keystone: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
In-Reply-To: <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-12-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5230562.E0gg2SNP0m@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:37 Krzysztof Kozlowski wrote:
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 0a6408a39c66..0f34846ae80d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -141,6 +141,7 @@ config POWER_RESET_XGENE
>  config POWER_RESET_KEYSTONE
>         bool "Keystone reset driver"
>         depends on ARCH_KEYSTONE
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select MFD_SYSCON
>         help
>           Reboot support for the KEYSTONE SoCs.
> 

This is platform specific, but we should probably add || COMPILE_TEST
along with the HAS_IOMEM dependency.

	Arnd
