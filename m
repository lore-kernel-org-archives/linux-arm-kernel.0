From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 12:38:58 +0200
Subject: [PATCH v8 2/2] ARM: EXYNOS: Move PMU specific definitions from
 common.h
In-Reply-To: <1412072481-22370-3-git-send-email-pankaj.dubey@samsung.com>
References: <1412072481-22370-1-git-send-email-pankaj.dubey@samsung.com>
 <1412072481-22370-3-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <11948982.c37J1JPj8N@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 15:51:21 Pankaj Dubey wrote:
> 
> +static inline void pmu_raw_writel(u32 val, u32 offset)
> +{
> +       __raw_writel(val, pmu_base_addr + offset);
> +}
> +
> +static inline u32 pmu_raw_readl(u32 offset)
> +{
> +       return __raw_readl(pmu_base_addr + offset);
> +}
> +
> 

While you're at it, please convert these to use readl_relaxed() instead,
which is safe to use in drivers and works independent of CPU endianess.

	Arnd
