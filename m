From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 24 May 2014 19:32:53 +0200
Subject: [PATCH] ARM: exynos: Fix kernel panic when unplugging CPU1 on 4210
In-Reply-To: <1400952255-13750-1-git-send-email-daniel.lezcano@linaro.org>
References: <537FBE42.7050608@gmail.com>
 <1400952255-13750-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5380D7C5.7080201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 24.05.2014 19:24, Daniel Lezcano wrote:
> A look at the code reveals use of S5P_VA_SYSRAM macro, in case of certain SoC
> revisions, which is not valid any longer, after SYSRAM started to be mapped
> dynamically. The new dynamic mapping is stored in sysram_base_addr variable,
> which is declared static in platsmp.c
> 
> This fix makes sysram_base_addr non-static, declared it in common.h and used
> in pm.c instead of S5P_VA_SYSRAM.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Suggested-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/common.h  |    1 +
>  arch/arm/mach-exynos/platsmp.c |    2 +-
>  arch/arm/mach-exynos/pm.c      |    4 ++--
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 

Looks good to me.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
