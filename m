From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Apr 2014 13:03:42 +0200
Subject: [PATCH v8 1/3] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <1397459860-21869-2-git-send-email-t.dakhran@samsung.com>
References: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com>
 <1397459860-21869-2-git-send-email-t.dakhran@samsung.com>
Message-ID: <5617478.sn2TYu7iO3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 April 2014 11:17:38 Tarek Dakhran wrote:
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -159,6 +159,15 @@ static struct map_desc exynos5250_iodesc[] __initdata = {
>         },
>  };
>  
> +static struct map_desc exynos5410_iodesc[] __initdata = {
> +       {
> +               .virtual        = (unsigned long)S5P_VA_SYSRAM_NS,
> +               .pfn            = __phys_to_pfn(EXYNOS5410_PA_SYSRAM_NS),
> +               .length         = SZ_4K,
> +               .type           = MT_DEVICE,
> +       },
> +};
> +
>  static struct map_desc exynos5_iodesc[] __initdata = {

NAK

Why does this keep coming up?

	Arnd
