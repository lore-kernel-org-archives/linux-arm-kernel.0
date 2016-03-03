From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 11:52:51 +0100
Subject: [RFC 02/15] dmaengine: nxp: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <1456992221-26712-3-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <2236480.r7GhWzq1NL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:28 Krzysztof Kozlowski wrote:
> index c77f214c9466..7fbf96bff280 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -290,6 +290,7 @@ config LPC18XX_DMAMUX
>         bool "NXP LPC18xx/43xx DMA MUX for PL080"
>         depends on ARCH_LPC18XX || COMPILE_TEST
>         depends on OF && AMBA_PL08X
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select MFD_SYSCON
>         help
> 

AMBA_PL08X implies HAS_IOMEM, so this is not needed explicitly

	Arnd
