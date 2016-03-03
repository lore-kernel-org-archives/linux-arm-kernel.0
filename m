From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 11:52:27 +0100
Subject: [RFC 01/15] clocksource: atmel: Add missing MFD_SYSCON dependency
 on HAS_IOMEM
In-Reply-To: <1456992221-26712-2-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4293319.qCj5tFri7J@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:27 Krzysztof Kozlowski wrote:
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c346be650892..5927944b46e0 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -239,6 +239,7 @@ config ATMEL_PIT
>  
>  config ATMEL_ST
>         bool
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select CLKSRC_OF
>         select MFD_SYSCON
> 

looking at this again, there is no need for the dependency here,
as it is not a user-selectable symbol.

	Arnd
