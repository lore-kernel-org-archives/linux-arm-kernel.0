From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Nov 2016 09:32:43 +0100
Subject: [PATCH v7 1/2] soc: samsung: add exynos chipid driver support
In-Reply-To: <cafc255a-3bdb-7eb2-1092-545866752858@samsung.com>
References: <1478347427-28409-1-git-send-email-pankaj.dubey@samsung.com>
 <1478347427-28409-2-git-send-email-pankaj.dubey@samsung.com>
 <cafc255a-3bdb-7eb2-1092-545866752858@samsung.com>
Message-ID: <1708820.kPMIhrYGr6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 7, 2016 8:35:47 AM CET Marek Szyprowski wrote:
> This approach is a bit error prone. You have already missed Exynos5410
> and early Exynos 4210 are not detected because of the incorrect SOC MASK.
> IMHO you should replace above code and defines with a simple array,
> where each ID is present only once, so it will be much easier to add
> future SoCs:
> 
> static const struct exynos_soc_id {
>          const char *name;
>          unsigned int id;
>          unsigned int mask;
> } soc_ids[] = {
>          { "EXYNOS3250", 0xE3472000, 0xFFFFF000 },
>          { "EXYNOS4210", 0x43200000, 0xFFFE0000 },
>          { "EXYNOS4212", 0x43220000, 0xFFFE0000 },
>          { "EXYNOS4412", 0xE4412000, 0xFFFE0000 },
>          { "EXYNOS4415", 0xE4415000, 0xFFFE0000 },
>          { "EXYNOS5250", 0x43520000, 0xFFFFF000 },
>          { "EXYNOS5260", 0xE5260000, 0xFFFFF000 },
>          { "EXYNOS5410", 0xE5410000, 0xFFFFF000 },
>          { "EXYNOS5420", 0xE5420000, 0xFFFFF000 },
>          { "EXYNOS5440", 0xE5440000, 0xFFFFF000 },
>          { "EXYNOS5800", 0xE5422000, 0xFFFFF000 },
> };

Good idea

> 
> I'm also not sure about Exynos 4415, which has been scheduled for removal.

I'd vote for leaving it in the driver, and possibly adding other
models even if we don't support them in the other drivers, if
only for documentation purposes.

	Arnd
