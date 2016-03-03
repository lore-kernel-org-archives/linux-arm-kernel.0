From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 11:53:23 +0100
Subject: [RFC 03/15] hwspinlock: qcom: Add missing MFD_SYSCON dependency
 on HAS_IOMEM
In-Reply-To: <1456992221-26712-4-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1850954.4r0iTkATb8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 17:03:29 Krzysztof Kozlowski wrote:
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index 73a401662853..5ab2d51dc147 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -21,6 +21,7 @@ config HWSPINLOCK_OMAP
>  config HWSPINLOCK_QCOM
>         tristate "Qualcomm Hardware Spinlock device"
>         depends on ARCH_QCOM
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select HWSPINLOCK
>         select MFD_SYSCON
>         help
> 

This is only needed if we add "|| COMPILE_TEST", right now the driver
is limited to ARCH_QCOM.

	Arnd
