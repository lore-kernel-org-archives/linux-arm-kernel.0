From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Jan 2013 21:24:35 -0800
Subject: [PATCH 0/3]  ARM:exynos5:power-domain: Save and restore
 CLK_TOP_SRC3 via clock framework.
In-Reply-To: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
References: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <05ba01cdfde0$ee4e6870$caeb3950$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prasanna Kumar wrote:
> 
> After Suspend-Resume operation of exynos5, CLK_TOP_SRC3 register
> modified
> while power gating G-scaler and MFC power domains.This is seen only after
> suspend and resume.
> 
> The solution to this problem is to save CLK_SRC_TOP3 register and restore
> it while powergating. But CLK_SRC_TOP3 register cannot accessed directly
> by power domain code.
> Please refer below URL to know the background of this issue.
> http://www.mail-archive.com/linux-samsung-
> soc at vger.kernel.org/msg14347.html.
> 
> This patch set adds clock framework support for save and restore
> clock register (CLK_SRC_TOP3)  for G-scaler and MFC power domains.
> 
> This patch set depends on
> http://www.mail-archive.com/linux-samsung-
> soc at vger.kernel.org/msg14648.html
> 
> Prasanna Kumar (3):
>   ARM: dts: exynos5: Add power domain clocks to pd node of Gscaler and
> MFC
>   ARM:exynos5:dts: Bindings for clock definitions are added.
>   ARM: exynos5: Add clock save and restore operation(CLK_SRC_TOP3) using
> clock framework.
> 
>  .../bindings/arm/exynos/power_domain.txt           |   14 ++
>  arch/arm/boot/dts/exynos5250.dtsi                  |    2 +
>  arch/arm/mach-exynos/pm_domains.c                  |  125
> ++++++++++++++++++++
>  3 files changed, 141 insertions(+), 0 deletions(-)
> 
> --
> 1.7.5.4

I think, you need to re-submit this after addressing comments from some
guys.

Thanks.

- Kukjin
