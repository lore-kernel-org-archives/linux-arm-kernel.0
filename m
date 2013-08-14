From: olof@lixom.net (Olof Johansson)
Date: Tue, 13 Aug 2013 23:48:30 -0700
Subject: [PATCH v6 3/4] ARM: hi3xxx: add board support with device tree
In-Reply-To: <1374813135-16238-4-git-send-email-haojian.zhuang@linaro.org>
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
 <1374813135-16238-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130814064830.GJ19951@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 26, 2013 at 12:32:14PM +0800, Haojian Zhuang wrote:
> Add board support with device tree for Hisilicon Hi36xx/Hi37xx platform.

How about a defconfig for build coverage, or enabling this platform in
multi_v7_defconfig?

> diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
> new file mode 100644
> index 0000000..a991dee
> --- /dev/null
> +++ b/arch/arm/mach-hi3xxx/Kconfig
> @@ -0,0 +1,13 @@
> +config ARCH_HI3xxx
> +	bool "Hisilicon Hi36xx/Hi37xx family" if ARCH_MULTI_V7
> +	select ARM_AMBA
> +	select ARM_GIC
> +	select CACHE_L2X0
> +	select CACHE_PL310

No other platforms select CACHE_PL310 even if they have them.

> +	select CLKSRC_OF
> +	select PINCTRL
> +	select PINCTRL_SINGLE
> +	select SERIAL_AMBA_PL011
> +	select SERIAL_AMBA_PL011_CONSOLE

It's not common to select the serial drivers here, only a couple of other
platforms do.



-Olof
