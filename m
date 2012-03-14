From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 Mar 2012 23:49:37 -0700
Subject: [PATCH v3 09/12] ARM: EXYNOS: add support get_core_count() for
 EXYNOS5250
In-Reply-To: <201203131615.49846.arnd@arndb.de>
References: <1331652643-12626-1-git-send-email-kgene.kim@samsung.com>
 <1331652643-12626-10-git-send-email-kgene.kim@samsung.com>
 <201203131615.49846.arnd@arndb.de>
Message-ID: <4F603F81.8040505@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/12 09:15, Arnd Bergmann wrote:
> On Tuesday 13 March 2012, Kukjin Kim wrote:
>> The EXYNOS5250 has two Cortex-A15 cores and there's no
>> need to call scu_enable() in platform_smp_prepare_cpus().
>>
>> Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
>
> Can you explain this patch more? It only seems to make the
> code less generic, but there is no indication if calling
> the scu_get_core_count() function is actually wrong on
> exynos5.
>
Contrary to Cortex-A9, Cortex-A15 has no regarding scu register so 
EXYNO5250 can not get the number of core from that like EXYNOS4 SoCs.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
