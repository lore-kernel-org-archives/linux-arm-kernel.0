From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 15:55:09 +0200
Subject: [PATCH v3 3/6] ARM: EXYNOS: Remove soc_is_exynos4/5 from exynos.c
In-Reply-To: <1399706419-13976-4-git-send-email-pankaj.dubey@samsung.com>
References: <1399706287-13919-1-git-send-email-y@samsung.com>
 <1399706419-13976-1-git-send-email-pankaj.dubey@samsung.com>
 <1399706419-13976-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53970E3D.9080501@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.05.2014 09:20, Pankaj Dubey wrote:
> This patch removes usage of soc_is_exynos4/5 from exynos.c.
> For this we need to separate machine descriptors for exynos4
> and exynos5. While doing this patch does some consolidation also.
> 
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Thomas Abraham <thomas.abraham@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c            |   52 +++++++++++++++++++-----------
>  arch/arm/plat-samsung/include/plat/cpu.h |    3 --
>  2 files changed, 33 insertions(+), 22 deletions(-)
> 

I don't think this is needed. All those static mappings should just go
away, which will also eliminate the need to have separate machine
descriptor or soc_is_exynos{4,5}() macros.

Best regards,
Tomasz
