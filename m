From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 00:06:26 -0700
Subject: [PATCH v3 05/12] ARM: EXYNOS: add support uart for EXYNOS4 and
 EXYNOS5
In-Reply-To: <201203131613.10620.arnd@arndb.de>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
 <1331652643-12626-6-git-send-email-kgene.kim@samsung.com>
 <201203131613.10620.arnd@arndb.de>
Message-ID: <4F604372.3040507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/12 09:13, Arnd Bergmann wrote:
> On Tuesday 13 March 2012, Kukjin Kim wrote:
>> Actually, the base address of uart is different between EXYNOS4
>> and EXYNOS5 and this patch enables to support uart for EXYNOS4
>> and EXYNOS5 SoCs at runtime.
>
> Can you explain why this patch is still needed? The exynos5250_dt_map_io
> function does not call s3c24xx_init_uarts() at all, so it seems that most
> of this patch just adds dead code that would only be needed for the non-dt
> case.
>
Yes, as you said, dt can support uart without most of this changes so we 
can drop adding/setup platform devices for uart here. But I thought 
non-dt exynos4 supporting is still available in mach-exynos/ and 
actually it is used for many product now and exynos5 can be selected for 
single zImage without CONFIG_OF. Even though we will move to only 
supporting dt world in mach-exynos/ for all of EXYNOS SoCs in the near 
future. So would be removed it when non-dt exynos4 does not support.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
