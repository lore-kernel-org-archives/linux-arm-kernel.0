From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Nov 2014 10:03:29 +0000
Subject: [PATCH v3 2/5] drivers: soc: Add support for Exynos PMU driver
In-Reply-To: <1416461968-2057-3-git-send-email-amit.daniel@samsung.com>
References: <1416461968-2057-1-git-send-email-amit.daniel@samsung.com>
 <1416461968-2057-3-git-send-email-amit.daniel@samsung.com>
Message-ID: <20141120100328.GO4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 11:09:25AM +0530, Amit Daniel Kachhap wrote:
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 063113d..44d220d 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_ARCH_QCOM)		+= qcom/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-$(CONFIG_SOC_TI)		+= ti/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
> +obj-$(CONFIG_ARCH_EXYNOS)	+= samsung/

Is ARCH_EXYNOS appropriate here, or is your new SOC_SAMSUNG better?

> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> new file mode 100644
> index 0000000..a424ebc
> --- /dev/null
> +++ b/drivers/soc/samsung/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# SAMSUNG SOC drivers
> +#
> +menuconfig SOC_SAMSUNG
> +	bool "Samsung SOC drivers support"

If you intend to select SOC_SAMSUNG, is there any point in making this
a user-visible symbol?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
